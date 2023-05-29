#!/home/danil/anaconda3/envs/stable/bin/python

from re import match
from sys import argv
from googletrans import Translator


TRANSLATOR = Translator()


def get_translate(word: str) -> str:
    word = word.strip().lower()

    if match('([а-яА-Я]+\s*)', word):
        translation = TRANSLATOR.translate(word, src='ru', dest='en').text
    else:
        translation = TRANSLATOR.translate(word, src='en', dest='ru').text

    return translation


if __name__ == "__main__":
    users_str = " ".join(argv[1:])

    tr_word = get_translate(word=users_str)
    print(tr_word)
