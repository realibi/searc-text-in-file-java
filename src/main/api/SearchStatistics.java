package api;

import java.util.ArrayDeque;
import java.util.Deque;
import java.util.Map;

public class SearchStatistics {
    private static SearchStatistics instance;
    private static Deque<Map<String, Integer>> resultStack = new ArrayDeque<>();
    private int totalFilesCount = 0;
    private int checkedFilesCount = 0;

    public static SearchStatistics getInstance() {
        if(instance == null){
            return new SearchStatistics();
        }
        return instance;
    }

    public void clearResultStack(){
        resultStack.clear();
    }

    public int getCheckedFilesCount() {
        return checkedFilesCount;
    }

    public void setCheckedFilesCount(int checkedFilesCount) {
        this.checkedFilesCount = checkedFilesCount;
    }

    public int getTotalFilesCount() {
        return totalFilesCount;
    }

    public void setTotalFilesCount(int totalFilesCount) {
        this.totalFilesCount = totalFilesCount;
    }

    public Deque<Map<String, Integer>> getResultStack() {
        return resultStack;
    }

    public synchronized void addFirst(Map<String, Integer> item){
        resultStack.addFirst(item);
        System.out.println("[LOG] addFirst");
        System.out.println("[LOG] current size of stack: " + resultStack.size());
    }

    public synchronized void addLast(Map<String, Integer> item){
        resultStack.addLast(item);
        System.out.println("[LOG] addLast");
        System.out.println("[LOG] current size of stack: " + resultStack.size());
    }

    public boolean allFilesChecked(){
        return checkedFilesCount == totalFilesCount;
    }
}
