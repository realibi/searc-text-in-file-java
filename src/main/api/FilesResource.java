package api;

import com.google.gson.Gson;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.*;

@Path("files")
public class FilesResource {
    Gson gson = new Gson();
    private String sourcePath = "E:\\dev\\JavaProjects\\textSearch\\cloud";

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public String getAllFiles(){
        final File folder = new File(sourcePath);
        File[] folderFiles = folder.listFiles();
        List<String> folderFileNames = new ArrayList<>();

        for(File file : folderFiles){
            folderFileNames.add(file.getName());
        }

        return gson.toJson(folderFileNames);
    }

    @GET
    @Path("/search/{text}")
    @Produces(MediaType.APPLICATION_JSON)
    public String searchText(@PathParam("text") String searchText) {
        final File folder = new File(sourcePath);
        File[] folderFiles = folder.listFiles();

        List<Thread> threadList = new ArrayList<>();

        for(File file : folderFiles){
            threadList.add(new SearchText(file, searchText));
            threadList.get(threadList.size()-1).start();
            try {
                threadList.get(threadList.size()-1).join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

        String result = gson.toJson(SearchStatistics.getInstance().getResultStack());
        SearchStatistics.getInstance().clearResultStack();

        return result;
    }
}
