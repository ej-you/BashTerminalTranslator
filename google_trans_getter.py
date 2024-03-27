from os import getenv
from re import match
from sys import argv

import httpcore

from dotenv import load_dotenv
from googletrans import Translator
from googletrans.client import Timeout


# чтение переменных окружения
load_dotenv()


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
    proxy_env = getenv('HTTPS_PROXY') or getenv('HTTP_PROXY')

    timeout_settings = Timeout(timeout=4.0, connect_timeout=2.0)

    if proxy_env:
        print_hint(f"{yellow_color}HINT: you are using system proxy.{default_color}")

        trnsl = Translator(proxies={proxy_env: ''}, timeout=timeout_settings)
    else:
        trnsl = Translator(timeout=timeout_settings)

    return trnsl


def get_translate(word: str) -> str:
    """Translate word and return translated word"""

    translator_class = get_translator_class()

    word = word.strip().lower()

    if match('([а-яА-Я]+\s*)', word):
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
        print_error('Please enter some text!')


if __name__ == "__main__":
    try:
        main()
    except httpcore.ProxyError:
        print_error('PROXY AUTH ERROR -- Check your proxy settings!')
    except httpcore.ConnectError:
        print_error('CONNECTION ERROR -- Check your Internet connection!')
    except httpcore.ConnectTimeout:
        print_error('CONNECTION TIMEOUT ERROR -- Check your Internet connection!')
    except KeyboardInterrupt:
        print_error('Keyboard exit')
    except Exception as error:
        print_error('UNKNOWN ERROR!')
        print(error)

    # print(get_translate(input('word: ')))
