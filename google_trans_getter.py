from googletrans import Translator
from re import match
from sys import argv


def get_translate(word: str) -> str:
    trnsl = Translator()

    word = word.strip().lower()

    if match('([а-яА-Я]+\s*)', word):
        translation = trnsl.translate(word, src='ru', dest='en').text
    else:
        translation = trnsl.translate(word, src='en', dest='ru').text

    return translation


def main() -> None:
    users_str = " ".join(argv[1:])

    if users_str:
        tr_word = get_translate(word=users_str)
        print(tr_word)
    else:
        print('Please enter some text')


if __name__ == "__main__":
    main()
