@show_contacts:
    ARTICLE(@article_cont)
return

@article_cont:
data "", 1
data @text_contacts

@text_contacts:
data 4
data "My contacts:"
data "\*", 4,  @contact_email
data "\*", 10, @contact_github
data "\*", 16, @contact_linkedin

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