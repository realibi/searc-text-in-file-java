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
import java.util.concurrent.Executor;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

@Path("files")
public class FilesResource {
    Gson gson = new Gson();
    private String sourcePath = "E:\\dev\\JavaProjects\\textSearch\\cloud";
    ExecutorService service = Executors.newCachedThreadPool();

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

        for(File file : folderFiles){
            service.execute(new SearchText(file, searchText));
        }

        try{
            service.shutdown();
            while (!service.awaitTermination(24L, TimeUnit.HOURS)) {
                System.out.println("Not yet. Still waiting for termination");
            }
        }catch(InterruptedException e){
            e.printStackTrace();
        }

        String result = gson.toJson(SearchStatistics.getInstance().getResultStack());
        SearchStatistics.getInstance().clearResultStack();

        return result;
    }

    @GET
    @Path("/search/stop")
    @Produces(MediaType.APPLICATION_JSON)
    public String stopSearch() {
        service.shutdownNow();

        return gson.toJson("ok");
    }
}
