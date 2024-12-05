import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class Main {
    public static void main(String[] args) throws Exception {
        Part1 part1 = new Part1();
        Part2 part2 = new Part2();
        List<String> grid = readInput(args[0]);
        int ans1 = part1.solve(grid);
        System.out.println("Part1 answer: " + ans1);
        int ans2 = part2.solve(grid);
        System.out.println("Part2 answer: " + ans2);
    }

    public static List<String> readInput(String filename) throws Exception {
        try (BufferedReader reader = new BufferedReader(new FileReader(filename))) {
            List<String> grid = reader.lines().collect(Collectors.toList());
            return grid;
        } catch (Exception e) {
            System.err.println("Error reading file!" + e.getMessage());
            throw e;
        }
    }
}

class Part1 {
    public int solve(List<String> grid) {
        int ans = 0;
        for (int i = 0; i < grid.size(); i++) {
            for (int j = 0; j < grid.get(i).length(); j++) {
                char c = grid.get(i).charAt(j);
                if (c == 'X') {
                    ans += checkAllDirections(i, j, grid);
                }
            }
        }
        return ans;
    }

    private int checkAllDirections(int x, int y, List<String> grid) {
        String ref = "XMAS";
        List<StringBuilder> candidate = new ArrayList<>();
        for (int i = 0; i < 8; i++) {
            candidate.add(new StringBuilder());
        }
        for (int i = 0; i < 4; i++) {
            helper(candidate.get(0), x, y - i, grid);
            helper(candidate.get(1), x, y + i, grid);
            helper(candidate.get(2), x + i, y, grid);
            helper(candidate.get(3), x - i, y, grid);
            helper(candidate.get(4), x + i, y + i, grid);
            helper(candidate.get(5), x + i, y - i, grid);
            helper(candidate.get(6), x - i, y + i, grid);
            helper(candidate.get(7), x - i, y - i, grid);
        }
        return candidate.stream()
                .map(StringBuilder::toString)
                .filter(ref::equals)
                .collect(Collectors.toList()).size();

    }

    private void helper(StringBuilder builder, int x, int y, List<String> grid) {
        if (x >= 0 && y >= 0 && x < grid.size() && y < grid.get(x).length()) {
            builder.append(grid.get(x).charAt(y));
        }
    }

}

class Part2 {
    public int solve(List<String> grid) {
        int ans = 0;
        StringBuilder diag1;
        StringBuilder diag2;
        for (int i = 0; i < grid.size() - 2; i++) {
            for (int j = 0; j < grid.get(i).length() - 2; j++) {
                if (grid.get(i + 1).charAt(j + 1) == 'A') {
                    diag1 = new StringBuilder();
                    diag2 = new StringBuilder();
                    diag1.append(grid.get(i).charAt(j));
                    diag1.append(grid.get(i + 1).charAt(j + 1));
                    diag1.append(grid.get(i + 2).charAt(j + 2));
                    diag2.append(grid.get(i).charAt(j + 2));
                    diag2.append(grid.get(i + 1).charAt(j + 1));
                    diag2.append(grid.get(i + 2).charAt(j));
                    String d1 = diag1.toString();
                    String d2 = diag2.toString();
                    if ((d1.equals("MAS") || d1.equals("SAM")) && (d2.equals("MAS") || d2.equals("SAM")))
                        ans++;
                }
            }
        }
        return ans;
    }

}