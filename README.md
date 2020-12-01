# web-application
### Сборка проекта
> 
    git clone https://github.com/aleks990316/web-application
    cd web-application
    swift build 
### Запуск проекта
> 
    
    OVERVIEW: Dictionary

    USAGE: ./.build/debug/Run <subcommand>

    OPTIONS:
    -h, --help              Show help information.

    SUBCOMMANDS:
    search (default)        Search throw dictionary
        OVERVIEW: Search throw dictionary

        USAGE: ./.build/debug/Run search [-k <k>] [-l <l>]

        OPTIONS:
        -k <k>                  word 
        -l <l>                  language 
        -h, --help              Show help information.
    update                  Add new data to dictionary
        OVERVIEW: Add new data to dictionary

        USAGE: ./.build/debug/Run update <word> -k <k> -l <l>

        ARGUMENTS:
        <word>                  A word to add

        OPTIONS:
        -k <k>                  word                
        -l <l>                  language 
        -h, --help              Show help information.
    delete                  Delete data from dictionary
        OVERVIEW: Delete data from dictionary

        USAGE: ./.build/debug/Run web-application delete [-k <k>] [-l <l>]

        OPTIONS:
            -k <k>                  word 
            -l <l>                  language 
            -h, --help              Show help information.
### Тестирование проекта
Системный тест:
>
    Tests/test.sh
   
Юнит-тест:
>
    swift test
