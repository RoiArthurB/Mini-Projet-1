function result = Echange(A, ln1, ln2)
    nbrCol = size(A, "c");
    for i=1:size(A, "r")
        for j=1:nbrCol
            if(i == ln1)
                result(i,j) = A(ln2,j);
            elseif (i == ln2 )
                result(i,j) = A(ln1,j);
            else
                result(i,j) = A(i,j);
            end
        end
    end
endfunction

function [result, ln] = ChoixPivot(A, col)
    //Boolean pour savoir si un résultat a été trouvé ou non
    fini = %f;
    for i=col:size(A, "r")
        if (A(i,col) <> 0) then
            //Retourne le premier résultat trouvé non nul
            result = A(i,col);
            ln = i;
            fini = %t;
            break;  //Fin de la fonction -> optimisation
        end
    end
    // Y a-t-il eu un résultat de trouvé?
    if (fini == %f) then
        result = 0; ln = 1;
    end
endfunction

function result = CombinaisonLineaire(A, ln1, ln2, l)
    ligneAAjouter = A(ln1, :);
    result = A;
    result(ln2, :) = result(ln2, :) - ligneAAjouter*l;
endfunction


function result = echelonnage(A)
    
    nbrCol = size(A, "c"); nbrLn = size(A, "r");
    
    
    // Pivot de Gauss
    for i=1:nbrCol   //Voyage par colonne
        
       // Vérif que l'indice soit non-nul
       [pivot, ln] = ChoixPivot(A, i);
       if(i <= nbrLn)   // Pour s'il n'y a pas de A(i,i)
          if(pivot <> A(i,i))   //Vérif si le pivot est sur une autre ligne
             A = Echange(A, i, ln); //Si oui
          end
       end
    
       //Pivot de Gauss
       if(pivot <> 0)   //Pour éviter la division par zéro (la colonne en est constituée)
           for j=(1+i):nbrLn //Voyage par ligne
              A = CombinaisonLineaire(A, i, j, ( A(j, i)/A(i,i) ) ) //Echelonne
           end
        end
    end
    
    result = A;
endfunction


// Test matrice devoir
M4 = [0 -1 1 1; -6 1 -2 -1; -5 2 -1 0]

M4 = echelonnage(M4);

disp( M4 )




