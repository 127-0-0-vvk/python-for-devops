from random import choices


def fruit():
    fruits = ["apple", "cherry", "melon"]
    return choices(fruits)[0]
