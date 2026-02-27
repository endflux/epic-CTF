

class Quiz:
    def __init__(self):
        self.questions = [
            {"question": "Who is the Wizard that helped King Arthur?", "options": ["Merlin", "Gandalf", "Dumbledore", "Oz"]},
            {"question": "Who fixes the sword?", "options": ["Lancelot", "The Lady of the Lake", "Guinevere", "Percival"]},
            {"question": "What is the name of the sword?", "options": ["Sting", "Excalibur", "Glamdring", "Orcrist"]},
            {"question": "Where does Arthur become king of?", "options": ["France", "England", "Scotland", "Wales"]},
            {"question": "Who made the animated movie about the sword in the stone?", "options": ["Dreamworks", "Disney", "Pixar", "Warner Bros"]},
            {"question": "What is the name of the animated movie?", "options": ["The Sword in the Stone", "Excalibur", "The King", "Camelot"]},
            {"question": "True or False: Do King Arthur and Robin Hood talk?", "options": ["True", "False"]}
        ]
        self.answers = ["Merlin", "The Lady of the Lake", "Excalibur", "England", "Disney", "The Sword in the Stone", "False"]
    
    def run(self):
        score = 0
        consecutive_correct = 0
        
        for i, q in enumerate(self.questions):
            print(f"\nQuestion {i+1}: {q['question']}")
            for j, option in enumerate(q['options'], 1):
                print(f"  {j}. {option}")
            
            answer = input("Your answer (1-4): ").strip()
            
            if answer.isdigit() and 1 <= int(answer) <= len(q['options']):
                selected_option = q['options'][int(answer)-1]
                if selected_option == self.answers[i]:
                    print("✓ Correct!")
                    score += 1
                    consecutive_correct += 1
                    
                    if consecutive_correct == 6:
                        print("\n🎉 You got 6 correct in a row!")
                        print("The sword hash: 9917f950a77755913566467ffcf1cb33b5101dc822c313390500b0fd080e4881")
                else:
                    print("✗ Incorrect.")
                    consecutive_correct = 0
            else:
                print("Invalid input.")

if __name__ == "__main__":
    quiz = Quiz()
    quiz.run()