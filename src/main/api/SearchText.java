package api;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Map;
import java.util.Scanner;

public class SearchText extends Thread {
    private final File file;
    private final String searchText;

    public SearchText(File file, String searchText){
        this.file = file;
        this.searchText = searchText;
    }

    @Override
    public void run() {
        int occurrences = 0;
        try {
            Scanner scanner = new Scanner(file);
            while (scanner.hasNext()) {
                String str = scanner.nextLine();
                int lastIndex = 0;

                while(lastIndex != -1){
                    lastIndex = str.indexOf(searchText,lastIndex);

                    if(lastIndex != -1){
                        occurrences ++;
                        lastIndex += searchText.length();
                    }
                }
            }
            scanner.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        System.out.println();
        if(file.getName().contains(searchText)){
            System.out.println("adding to first");
            SearchStatistics.getInstance().addFirst(Map.<String, Integer>of(file.getName(), occurrences));
        }
        else{
            System.out.println("adding to last");
            SearchStatistics.getInstance().addLast(Map.<String, Integer>of(file.getName(), occurrences));
        }

        SearchStatistics.getInstance().setCheckedFilesCount(SearchStatistics.getInstance().getCheckedFilesCount() + 1);
    }
}
