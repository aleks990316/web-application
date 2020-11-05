# web-application
### Сборка проекта
> 
    git clone https://github.com/aleks990316/web-application
    cd web-application
    swift build 
### Запуск проекта
> 
    
    OVERVIEW: Dictionary

    USAGE: swit run web-application <subcommand>

    OPTIONS:
    -h, --help              Show help information.

    SUBCOMMANDS:
    search (default)        Search throw dictionary
        OVERVIEW: Search throw dictionary

        USAGE: swift run web-application search [-k <k>] [-l <l>]

        OPTIONS:
        -k <k>                  word 
        -l <l>                  language 
        -h, --help              Show help information.
    update                  Add new data to dictionary
        OVERVIEW: Add new data to dictionary

        USAGE: swift run update <word> -k <k> -l <l>

        ARGUMENTS:
        <word>                  A word to add

        OPTIONS:
        -k <k>                  word                
        -l <l>                  language 
        -h, --help              Show help information.
    delete                  Delete data from dictionary
        OVERVIEW: Delete data from dictionary

        USAGE: swift run web-application delete [-k <k>] [-l <l>]

        OPTIONS:
            -k <k>                  word 
            -l <l>                  language 
            -h, --help              Show help information.

Добавлена библиотека PrettyColors, которая позволяет менять цвет и шрифт консольного вывода. Можно явно отделять язык от перевода на этом языке и т.д.