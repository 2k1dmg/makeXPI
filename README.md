#### makeXPI
Этот файл ([makeXPI.cmd](https://github.com/2k1dmg/makeXPI/releases)) нужно разместить в какой-нибудь папке например `C:\cmdtools` и добавить этот путь в переменные среды Windows. Это позволит запускать его в любой папке.
Нужно перейти в нужную папку (например `my-addon-name`) например через проводник и зажав "Shift" щёлкнуть правой кнопкой мыши и выбрать "Открыть окно команд". В появившуюся консоль ввести:
- `makexpi` - создаст дополнение (если есть файлы `install.rdf` или `manifest.json`) в текущей папке из файлов в текущей папке исключая то, что есть в списке переменной `_exclude`. Имя файла будет в таком виде: `my-addon-name-0.2.0.xpi` (или `my-addon-name-2014-06-20.xpi` если опредилить версию не удалось) т.е имя папки, версия или текущая дата.
- `makexpi init` - создаст шаблон `install.rdf` и пустые файлы `bootstrap.js` и `chrome.manifest`.
- `makexpi init rdf2` - тоже что и `makexpi init`, но с другим видом `install.rdf`.
- `makexpi init we` - создаст шаблон `manifest.json` и пустой файл `background.js`.
- `makexpi run` - создаст профиль во временной папке Windows в нём создаст файл настроек и дополнение. Это не затронет дополнение в текущей папке.
- `makexpi run [esr, sm...]` - тоже что и `makexpi run`, но с выбором конкретного браузера прописанного в файле `makeXPI.cmd`. Пути к файлам нужно добавить самому. Примеры `makexpi run esr`, `makexpi run pm` или же указать путь к `exe` файлу `makexpi run "d:\progs\fx\firefox.exe"`.

Если в тоже папке что и `makeXPI.cmd` создать папку `makexpiconf`, то файлы `install.rdf`, `install2.rdf`, `manifest.json`, `user.js` будут использоваться как шаблоны, а `bins.txt` для задания путей к файлам запуска
```
fx=d:\progs\fx\firefox.exe
beta=d:\progs\fx beta\firefox.exe
```
Для упаковки нужен установленный 7-zip или 7za.exe в том же каталоге что и `makeXPI.cmd`.