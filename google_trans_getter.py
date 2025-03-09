from re import match
from sys import argv

import httpcore
import readline

from googletrans import Translator
from googletrans.client import Timeout


# Отключение обработки управляющих символов (для корректной работы стрелок клавиатуры в терминале)
readline.parse_and_bind("")


red_bold_color = '\033[1m\033[31m'
yellow_color = '\033[33m'
default_color = '\033[0m'


def print_error(error_text: str) -> None:
    """Print error_text in red color"""

    print(red_bold_color + error_text + default_color)


def print_hint(error_text: str) -> None:
    """Print hint_text in yellow color"""

    print(yellow_color + error_text + default_color)


def get_translator_class() -> Translator:
    """Get translator class"""

    timeout_settings = Timeout(timeout=4.0, connect_timeout=2.0)
    trnsl = Translator(timeout=timeout_settings, proxies={})
    return trnsl


def get_translate(word: str) -> str:
    """Translate word and return translated word"""

    translator_class = get_translator_class()
    word = word.strip().lower()

    if match(r'([а-яА-Я]+\s*)', word):
        translation = translator_class.translate(word, src='ru').text
    else:
        translation = translator_class.translate(word, src='en', dest='ru').text

    return translation


def main() -> None:
    users_str = " ".join(argv[1:])

    if users_str:
        tr_word = get_translate(word=users_str)
        print(tr_word)
    else:
        print_hint('You have activated the "command line" mode of BashTerminalTranslator.\nTo exit use Ctrl+C shortcut.')
        while True:
            try:
                # считывание введённой команды
                interactive_word = input('trans> ').strip()

                # если было введено слово
                if interactive_word:
                    tr_word = get_translate(word=interactive_word)
                    print(tr_word)

            # выход из программы
            except KeyboardInterrupt:
                print_error('\nGoodbye!')
                break
            # ошибка соединения
            except httpcore.ConnectError:
                print_error('CONNECTION ERROR -- Check your Internet connection!')
            # ошибка соединения
            except httpcore.ConnectTimeout:
                print_error('CONNECTION TIMEOUT ERROR -- Check your Internet connection!')
            # неизвестная ошибка
            except Exception as err:
                print_error(f'UNKNOWN ERROR -- {err}')


if __name__ == "__main__":
    try:
        main()
    # ошибка соединения
    except httpcore.ConnectError:
        print_error('CONNECTION ERROR -- Check your Internet connection!')
    # ошибка соединения
    except httpcore.ConnectTimeout:
        print_error('CONNECTION TIMEOUT ERROR -- Check your Internet connection!')
    # выход из программы
    except KeyboardInterrupt:
        print_error('Keyboard exit')
    # неизвестная ошибка
    except Exception as error:
        print_error(f'UNKNOWN ERROR -- {error}')

    # print(get_translate(input('word: ')))
