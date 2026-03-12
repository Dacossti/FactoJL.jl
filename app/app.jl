using Bonito
using Bonito: onjs, onload, Button
# Create a reactive counter app
app = App() do session
    count = Observable(0)
    
    button = Button("Click me!")

    on(click -> begin
        count[] += 1
                end, 
    button)
    
    # Composant UploadButton

    struct MyUploadButton
        button::Bonito.Button      # bouton visible Bonito
        file_input::Any            # input file caché
        file::Observable           # Observable contenant le fichier sélectionné
    end

    function MyUploadButton(label::String)
    # 1) Bouton Bonito visible
    btn = Button(label)

    # 2) Input file caché
    file_in = DOM.input(; type="file", style="display:none;")

    # 3) Observable où on émettra le fichier choisi
    file_obs = Observable(nothing)

    # 4) Lorsque l'utilisateur clique sur le bouton Bonito → ouvrir sélecteur fichier
    on(btn) do _
        Bonito.eval(file_in, js"this.click()")
    end

    # 5) Lorsque le fichier est sélectionné → l'envoyer dans l'observable
    Bonito.on(file_in.files) do files
        if !isempty(files)
            file_obs[] = first(files)
        end
    end

    return MyUploadButton(btn, file_in, file_obs)
    end

    # Permet d'écrire : on(f -> ..., myuploadbutton)
    function Base.on(f::Function, up::MyUploadButton)
    return on(f, up.file)
    end



    
    return DOM.div(button, MyUploadButton("Upload a file"), DOM.h1("Count: ", count))
end