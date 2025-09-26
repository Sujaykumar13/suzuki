package com.suzuki.util;

public class InitCaseConverter {


        public static String toInitCase(String input) {
            if (input == null || input.isEmpty()) {
                return input;
            }

            StringBuilder result = new StringBuilder();
            String[] words = input.split("\\s+"); // Split by spaces

            for (String word : words) {
                if (word.length() > 0) {
                    String firstLetter = word.substring(0, 1).toUpperCase();
                    String restOfWord = word.substring(1).toLowerCase();
                    result.append(firstLetter).append(restOfWord).append(" ");
                }
            }

            return result.toString().trim(); // Remove trailing space
        }

}
