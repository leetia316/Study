package lexer;

import java.util.Arrays;
import java.util.HashSet;

public class Keywords {
    static String[] keywords = {
            "var",
            "if",
            "else",
            "for",
            "while",
            "break",
            "func",
            "return"
    };

    static HashSet<String> set = new HashSet<>(Arrays.asList(keywords));

    /**
     * 判断是否是关键词
     * @param word {String}
     * @return {boolean}
     */
    public static boolean isKeyword(String word) {
        return set.contains(word);
    }
}
