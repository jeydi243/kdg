import math


def calculate_sin_over_x():
    for i in range(-3,3):
        try:
            result = math.sin(i) / i
            print(result)
        except ZeroDivisionError:
            print(f"La valeur de {i=} entraîne une division par zéro")
            return None
        
calculate_sin_over_x()