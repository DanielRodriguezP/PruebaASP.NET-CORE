using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EjerciciosLogica
{
    class Program
    {
        private static int add;
        private static int multiple;
        private static string phrase;

        static void Main(string[] args)
        {

            char option;
            Console.WriteLine("Welcome to System");
            Console.WriteLine("\t");
            do
            {
                Console.WriteLine("\t*******************************************************");
                Console.WriteLine("\t* Type the option                                   *");
                Console.WriteLine("\t* 1: Sum of multiples of 3 and 5                    *");
                Console.WriteLine("\t* 2: Function camel case                            *");
                Console.WriteLine("\t* 3: Transform word greater than 5 letters          *");
                Console.WriteLine("\t* 0: Leave                                          *");
                Console.WriteLine("\t*******************************************************");
                Console.Write("Option: ");
                Console.WriteLine("\t");
                do
                {
                    option = Console.ReadKey(true).KeyChar;
                } while (option < '0');
                Console.WriteLine(option + "\n");

                switch (option)
                {
                    case '1':
                        int number = 0;
                        Console.WriteLine("Enter positive number");
                        number = Convert.ToInt32(Console.ReadLine());
                        int result = multiples(number);
                        Console.WriteLine($"the sum of the multiples of 3 and 5 less than {number} is: " + result);

                        break;
                    case '2':

                        Console.WriteLine("Enter the phrase");
                        phrase = Console.ReadLine().ToString();
                        string resulCameCasel = metodoCameCasel(phrase);
                        Console.WriteLine($"The phrase with the camel case funtion is : { resulCameCasel } ");

                        break;
                    case '3':
                        Console.WriteLine("Enter the phrase");
                        phrase = Console.ReadLine();
                        string reversePhrase = wordBackwards(phrase);
                        Console.WriteLine($"The transformation of the phrase is: { reversePhrase } ");
                        break;
                    default:
                        Console.WriteLine("ERROR. Wrong number");
                        break;
                }
            } while (option != '0');
        }
        public static int multiples(int number)
        {
            multiple = 0;
            add = 0;
            for (int i = 0; i < number; i++)
            {
                if (i % 5 == 0)
                {
                    multiple = i;
                    if (multiple < number)
                        add = add + multiple;
                    else break;
                }
                if (i % 3 == 0)
                {
                    multiple = i;
                    if (multiple < number)
                        add = add + multiple;
                    else break;
                }

            }
            return add;
        }
        public static string metodoCameCasel(string word)
        {
            string CamelCaseWord = "";

            for (int i = 0; i < word.Length; i++)
            {
                if (word[i] == ' ' || word[i] == '_' || word[i] == '-')
                {
                    i = i + 1;
                    CamelCaseWord = CamelCaseWord + char.ToUpper(word[i]);
                }
                else
                {
                    CamelCaseWord = CamelCaseWord + word[i];
                }
            }
            return CamelCaseWord;
        }
        public static string wordBackwards(string word)
        {

            string invertedPhrase = "";
            string[] words = word.Split(' ');
            for (int i = 0; i < words.Length; i++)
            {
                if (words[i].Length > 5)
                {
                    string wordToInvert = words[i];
                    string invertedWord = "";
                    for (int j = wordToInvert.Length - 1; j >= 0; j--)
                    {
                        invertedWord = invertedWord + wordToInvert[j];
                    }
                    invertedPhrase = invertedPhrase + " " + invertedWord;
                }
                else
                {
                    invertedPhrase = invertedPhrase + " " + words[i];
                }
            }
            return invertedPhrase;

        }
    }
}
