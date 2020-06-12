package lexer;

import common.PeekIterator;
import org.junit.jupiter.api.Test;

import static org.junit.Assert.assertEquals;

public class TokenTests {

    void assertToken(Token token, String value, TokenType type) {
        assertEquals(type, token.getType());
        assertEquals(value, token.getValue());
    }

    @Test
    public void test_varOrKeyword() {
        PeekIterator<Character> it1 = new PeekIterator<Character>("if abc".chars().mapToObj(x -> (char) x));
        PeekIterator<Character> it2 = new PeekIterator<Character>("true abc".chars().mapToObj(x -> (char) x));
        Token token1 = Token.makeVarOrKeyword(it1);
        Token token2 = Token.makeVarOrKeyword(it2);

        assertToken(token1, "if", TokenType.KEYWORD);
        assertToken(token2, "true", TokenType.BOOLEAN);
        it1.next();
        Token token3 = Token.makeVarOrKeyword(it1);
        assertToken(token3, "abc", TokenType.VARIABLE);
    }

    @Test
    public void test_makeString() throws LexicalException {
        String[] tests = {
                "\"123\"",
                "\'123\'"
        };

        for (String test : tests) {
            PeekIterator<Character> it = new PeekIterator<>(test.chars().mapToObj(x -> (char) x));
            Token token = Token.makeString(it);
            assertToken(token, test, TokenType.STRING);

        }
    }

    @Test
    public void test_makeOperator() throws LexicalException {
        String[] tests = {
                "+ xxx",
                "++mmm",
                "/=g",
                "==1",
                "&=3982",
                "&777",
                "||xxx",
                "^=111",
                "%7"
        };

        String[] results = {"+", "++", "/=", "==", "&=", "&", "||", "^=", "%"};

        int i = 0;
        for (String test : tests) {
            PeekIterator<Character> it = new PeekIterator<>(test.chars().mapToObj(x -> (char) x));
            Token token = Token.makeOp(it);
            assertToken(token, results[i++], TokenType.OPERATOR);
        }
    }

    @Test
    public void test_makeNumber() throws LexicalException {
        String[] tests = {
                "+0 aa",
                "-0 aa",
                ".3 ccc",
                ".5555 ddd",
                "7789.8888 ooo",
                "-1000.123123*123123"
        };

        for(String test:tests) {
            PeekIterator<Character> it = new PeekIterator<>(test.chars().mapToObj(x -> (char) x));
            Token token = Token.makeNumber(it);
            String[] splitValue = test.split("[* ]+");
            assertToken(token, splitValue[0], (test.indexOf('.') != -1 ? TokenType.FLOAT : TokenType.INTEGER));
        }
    }
}
