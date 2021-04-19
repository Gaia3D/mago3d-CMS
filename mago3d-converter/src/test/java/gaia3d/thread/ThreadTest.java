package gaia3d.thread;

import static org.junit.jupiter.api.Assertions.*;

import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;

import javax.management.RuntimeErrorException;

import org.junit.jupiter.api.Test;

import lombok.extern.slf4j.Slf4j;

@Slf4j
class ThreadTest {

	@Test
	void test() throws InterruptedException, ExecutionException {
		CompletableFuture.supplyAsync( () -> {
            log.info("supplyAsync");
            
//            int a = 3;
//            if(a > 2) throw new RuntimeException("test");
            
            return 1;
        })
//        // return이 CompletableFuture인 경우 thenCompose를 사용한다.
//        .thenCompose(s -> {
//            log.info("thenApply {}", s);
//            if (1 == 1) throw new RuntimeException();
//            return CompletableFuture.completedFuture(s + 1);
//        })
//        // 앞의 비동기 작업의 결과를 받아 사용해 새로운 값을 return 한다.
//        .thenApply(s -> {
//            log.info("thenApply {}", s);
//            return s + 1;
//        })
		// 앞의 비동기 작업의 결과를 받아 사용하며 return이 없다.
        .thenAccept(s -> {
        	log.info("thenAccept {}", s);
        	System.out.println(" then Accept 만 들어 옴");
        })
        .exceptionally(e -> {
            log.info("exceptionally");
            System.out.println(" exceptionally 만 들어옴");
            return null;
        });
        
		
		log.info("exit");
	}
}
