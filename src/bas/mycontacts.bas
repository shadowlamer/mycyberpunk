@show_contacts:
    cls
    print ink 4; "My contacts"
    let contactPos = 4
    let pContact = @contact_email
    go sub @show_contact
    let contactPos = 10
    let pContact = @contact_github
    go sub @show_contact
    let contactPos = 16
    let pContact = @contact_linkedin
    go sub @show_contact
    go sub @wait
return

@contact_email:
data \
    "My email: sl\@anhot.ru",\
    "",\
    "",\
    "",\
    GENQR(mailto:sl@anhot.ru)

@contact_github:
data \
    "My GitHub profile:         ",\
    "https://github.com         ",\
    "               /shadowlamer",\
    "",\
    GENQR(https://github.com/shadowlamer)

@contact_linkedin:
data \
    "My LinkedIn profile:       ",\
    "https://linkedin.com/in    ",\
    "               /shadowlamer",\
    "",\
    GENQR(https://linkedin.com/in/shadowlamer)