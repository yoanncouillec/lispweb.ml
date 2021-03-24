type type_simple =
  | TVariable of variable_de_type
  | Terme of string * type_simple array

and variable_de_type =
  { mutable niveau: int;
    mutable valeur: valeur_dune_variable }

and valeur_dune_variable =
  | Inconnue
  | Connue of type_simple

exception Erreur of string
exception Conflit of type_simple * type_simple
exception Circularite of type_simple * type_simple

let type_int = Terme("int", [||])
and type_bool = Terme("bool", [||])
and type_fleche t1 t2 = Terme("->", [|t1;t2|])
and type_produit t1 t2 = Terme("*", [|t1;t2|])
and type_liste t = Terme("list", [|t|])


type schema_de_types =
  { parametres: variable_de_type list;
    corps: type_simple }

type environnement = (string * schema_de_types) list

let schema_trivial ty = {parametres = [] ; corps = ty}

let type_arithmetique = schema_trivial
                          (type_fleche (type_produit type_int type_int) type_int)

and type_comparaison = schema_trivial
                         (type_fleche (type_produit type_int type_int) type_bool)

let env_initial =
  ["+", type_arithmetique;
   "-", type_arithmetique]

let niveau_de_liaison = ref 0
let debut_de_definition () = incr niveau_de_liaison
and fin_de_definition () = decr niveau_de_liaison
let nouvelle_inconnue () = TVariable{niveau = !niveau_de_liaison; valeur = Inconnue}

let rec valeur_de = function
  | TVariable({valeur = Connue ty1} as var) ->
     let valeur_de_ty1 = valeur_de ty1 in
     var.valeur <- Connue valeur_de_ty1;
     valeur_de_ty1
  | ty -> ty

let generalisation ty =
  let parametres = ref [] in
  let rec trouve_parametres ty =
    match valeur_de ty with
    | TVariable var ->
       if var.niveau > !niveau_de_liaison && (not (List.memq var !parametres))
       then parametres := var :: !parametres
    | Terme(constr, arguments) ->
       Array.iter trouve_parametres arguments in
  trouve_parametres ty;
  {parametres = !parametres ; corps = ty}

let specialisation schema =
  match schema.parametres with
  | [] -> schema.corps
  | parametres ->
     let nouvelles_inconnues =
       List.map (fun var -> (var, nouvelle_inconnue())) parametres in
     let rec copie ty =
       match valeur_de ty with
         TVariable var as ty ->
          begin try
              List.assq var nouvelles_inconnues
            with Not_found ->
              ty
          end
       | Terme(constr, arguments) ->
          Terme(constr, Array.map copie arguments) in
     copie schema.corps

let test_doccurence var ty =
  let rec test t =
    match valeur_de t with
      TVariable var' ->
       if var == var' then raise (Circularite(TVariable var, ty))
      | Terme (constructeur, arguments) ->
         Array.iter test arguments
  in test ty

let rec rectifie_niveaux niveau_max ty =
  match valeur_de ty with
    TVariable var ->
     if var.niveau > niveau_max then var.niveau <- niveau_max
    | Terme(constructeur, arguments) ->
       Array.iter (rectifie_niveaux niveau_max) arguments

let rec unifie ty1 ty2 =
  let valeur1 = valeur_de ty1
  and valeur2 = valeur_de ty2 in
  if valeur1 == valeur2 then () else
    match (valeur1, valeur2) with
    | (TVariable var), ty ->
       test_doccurence var ty;
       rectifie_niveaux var.niveau ty;
       var.valeur <- Connue ty
    | ty, TVariable var ->
       test_doccurence var ty;
       rectifie_niveaux var.niveau ty;
       var.valeur <- Connue ty
    | Terme (constr1, arguments1), Terme(constr2, arguments2) ->
       if constr1 <> constr2 then
         raise (Conflit(valeur1, valeur2))
       else
         for i = 0 to (Array.length arguments1) - 1 do
           unifie arguments1.(i) arguments2.(i)
         done

let rec type_motif env = function
    Motif_variable id ->
     let ty = nouvelle_inconnue() in
     (ty, (id, schema_trivial ty) :: env)
  | Motif_booleen b -> (type_bool, env)
  | Motif_nombre n -> (type_int, env)
  | Motif_paire(m1, m2) ->
     let (ty1, env1) = type_motif env m1 in
     let (ty2, env2) = type_motif env1 m2 in
     (type_produit ty1 ty2, env2)
  | Motif_nil ->
     (type_liste (nouvelle_inconnue()), env)
  | Motif_cons(m1, m2) ->
     let (ty1, env1) = type_motif env m1 in
     let (ty2, env2) = type_motif env1 m2 in
     unifie (type_liste ty1) ty2;
     (ty2, env2)

let rec type_exp env = function
  | Variable id ->
     begin
       try
         specialisation (List.assoc id env)
       with Not_found ->
         raise(Erreur("Unbound value "^id))
     end
  | Fonction liste_de_cas ->
     let type_argument = nouvelle_inconnue()
     and type_resultat = nouvelle_inconnue() in
     let type_cas (motif, expr) =
       let (type_motif, env_etendu) = type_motif env motif in
       unifie type_motif type_argument;
       let type_expr = type_exp env_etendu expr in
       unifie type_expr type_resultat in
     List.iter type_cas liste_de_cas;
     type_fleche type_argument type_resultat
  | Application (fonction, argument) ->
     let type_fonction = type_exp env fonction in
     let type_argument = type_exp env argument in
     let type_resultat = nouvelle_inconnue() in
     unifie type_fonction (type_fleche type_argument type_resultat);
     type_resultat
  | Let(recursive,nom,expr, body) ->
     type_exp (type_def env recursive nom expr) body
  | Define(recursive,nom,expr) ->
     failwith "should never happen"
  | Booleen b -> type_bool
  | Nombre n -> type_int
  | Paire(e1,e2) -> type_produit (type_exp env e1) (type_exp env e2)
  | Nil -> type_liste (nouvelle_inconnue())
  | Cons(e1, e2) ->
     let type_e1 = type_exp env e1 in
     let type_e2 = type_exp env e2 in
     unifie (type_liste type_e1) type_e2;
     type_e2
  | Plus(e1,e2) | Minus(e1,e2) ->
     let type_e1 = type_exp env e1 in
     let type_e2 = type_exp env e2 in
     unifie type_e1 type_int;
     unifie type_e2 type_int;
     type_int
     
and type_def env recursive nom expr =
  debut_de_definition();
  let type_expr =
    match recursive with
      false -> type_exp env expr
    | true ->
       let type_provisoire = nouvelle_inconnue() in
       let type_expr =
         type_exp ((nom, schema_trivial type_provisoire) :: env)
           expr in
       unifie type_expr type_provisoire;
       type_expr in
  fin_de_definition();
  (nom, generalisation type_expr) :: env

let noms_des_variables = ref ([] : (variable_de_type * string) list)
and compteur_de_variables = ref 0

let imprime_var var =
  print_string "'";
  try
    print_string(List.assq var !noms_des_variables)
  with Not_found ->
        let nom =
          String.make 1
            (char_of_int(int_of_char 'a' + !compteur_de_variables)) in
        incr compteur_de_variables;
        noms_des_variables := (var, nom) :: !noms_des_variables;
        print_string nom

let rec imprime ty =
  (match valeur_de ty with
   | TVariable var -> imprime_var var
   | Terme(constructeur, arguments) ->
      match Array.length arguments with
      | 0 -> print_string constructeur
      | 1 -> imprime arguments.(0);
             print_string " "; print_string constructeur
      | 2 -> print_string "("; imprime arguments.(0);
             print_string " "; print_string constructeur;
             print_string " "; imprime arguments.(1);
             print_string ")";
      | _ -> failwith "not implemented")

let imprime_type ty =
  noms_des_variables := [];
  compteur_de_variables := 0;
  imprime ty

let imprime_schema schema =
  noms_des_variables := [];
  compteur_de_variables := 0;
  if schema.parametres <> [] then begin
      print_string "pour tout ";
      List.iter (fun var -> imprime_var var; print_string " ")
        schema.parametres;
      print_string ", "
    end;
  imprime schema.corps
