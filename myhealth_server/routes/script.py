import pickle
import numpy as np
import sys
import json


def read_in():
    lines = sys.stdin.readlines()
    # Since our input would only be having one line, parse our JSON data from that
    return json.loads(lines[0])

 
specialist_dictionary = {
    0: "Dermatologist", 1: "Dermatologist", 15: "Dermatologist", 18: "Dermatologist", 25: "Dermatologist", 33: "Dermatologist",
    2: "Infectious Disease Specialist", 3: "Infectious Disease Specialist", 5: "Infectious Disease Specialist", 6: "Infectious Disease Specialist", 7: "Infectious Disease Specialist", 21: "Infectious Disease Specialist", 24: "Infectious Disease Specialist", 30: "Infectious Disease Specialist", 31: "Infectious Disease Specialist", 38: "Infectious Disease Specialist", 39: "Infectious Disease Specialist",
    4: "Orthopedic", 9: "Orthopedic",
    10: "Allergist", 26: "Allergist",
    11: "Endocrinologist", 16: "Endocrinologist", 19: "Endocrinologist", 23: "Endocrinologist",
    12: "Gastroenterologist", 17: "Gastroenterologist", 28: "Gastroenterologist", 29: "Gastroenterologist", 32: "Gastroenterologist", 36: "Gastroenterologist", 37: "Gastroenterologist",
    13: "Cardiologist", 35: "Cardiologist",
    14: "Neurologist", 22: "Neurologist", 27: "Neurologist",
    20: "Urologist",
    34: "ENT Specialist",
    8: "Pulmonologist", 40: "Pulmonologist"
}

filename = 'F:/Minor-Project/myhealth_server/routes/final_model.sav'
loaded_model = pickle.load(open(filename, 'rb'))


def data_entry(symptoms_index_array):
    a = np.zeros((1, 132), dtype=int)
    for x in symptoms_index_array:
        a[0, x] = 1
    return a


index = read_in()
data_array = np.array(index)
# array=[4,24,25,27,106,107]
result = loaded_model.predict(data_entry(data_array))
# print(specialist_dictionary[int(result)])

def main():
    print(specialist_dictionary[int(result)])

if __name__ == "__main__":
    main()
