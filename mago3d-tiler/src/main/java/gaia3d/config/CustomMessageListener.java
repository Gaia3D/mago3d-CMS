package gaia3d.config;

import gaia3d.domain.TileInfo;
import gaia3d.domain.TileMessage;
import gaia3d.domain.TilerJobStatus;
import gaia3d.maker.PostProcess;
import gaia3d.support.LogMessageSupport;
import gaia3d.support.ProcessBuilderSupport;
import gaia3d.utils.FileUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.context.annotation.PropertySource;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CompletableFuture;

@Slf4j
@EnableAsync
@RequiredArgsConstructor
@PropertySource("classpath:mago3d.properties")
@Component
public class CustomMessageListener {

    private final PropertiesConfig propertiesConfig;
    private final PostProcess postProcess;

    @Async
    @RabbitListener(queues = {"${mago3d.rabbitmq-tiler-queue}"})
    public void receiveMessage(final TileMessage tileMessage) {
		log.info("--------------- tiling tileMessage = {}", tileMessage);

		final String PREFIX = "-";

		CompletableFuture.supplyAsync( () -> {
			List<String> command = new ArrayList<>();
			command.add(propertiesConfig.getTilerDir());

			command.add(PREFIX + "inputFile");
			command.add(tileMessage.getFilePath() + tileMessage.getFileName());

			command.add(PREFIX + "outputFolder");
			String outputFolder = propertiesConfig.getAdminTileServiceDir() + tileMessage.getTileKey();
			FileUtils.makeDirectory(outputFolder);
			command.add(outputFolder);

			command.add(PREFIX + "log");
			command.add(propertiesConfig.getTileLogDir());

			command.add(PREFIX + "indexing");
			command.add("y");

			log.info(" >>>>>> command = {}", String.join(" ", command));

			String result;
			try {
				int exitCode = ProcessBuilderSupport.execute(command);
				if (exitCode == 0) result = TilerJobStatus.SUCCESS.name().toLowerCase();
				else result = TilerJobStatus.FAIL.name().toLowerCase();
			} catch (InterruptedException | IOException e) {
				result = TilerJobStatus.FAIL.name().toLowerCase();
				LogMessageSupport.printMessage(e);
			} catch (Exception e) {
				result = TilerJobStatus.FAIL.name().toLowerCase();
				LogMessageSupport.printMessage(e);
			}
			return result;
        })
		.exceptionally(e -> {
			// 스마트 타일링 실패 전송
			TileInfo tileInfo = tileMessage.toTileInfo();
			tileInfo.setStatus(TilerJobStatus.FAIL);
			postProcess.updateTileInfo(tileInfo);
			LogMessageSupport.printMessage(new Exception(e));
			return null;
        })
		// 앞의 비동기 작업의 결과를 받아 사용하며 return이 없다.
		.thenAccept(status -> {
			log.info("thenAccept status = {}", status);
			try {
				// 스마트 타일링 성공 전송
				TileInfo tileInfo = tileMessage.toTileInfo();
				tileInfo.setStatus(TilerJobStatus.SUCCESS);
				postProcess.updateTileInfo(tileInfo);
			} catch (Exception e) {
				// 스마트 타일링 실패 전송
				log.info(" PostProcess.execute exception. message = {} ", e.getMessage());
				
				TileInfo tileInfo = tileMessage.toTileInfo();
				tileInfo.setStatus(TilerJobStatus.FAIL);
				postProcess.updateTileInfo(tileInfo);
				LogMessageSupport.printMessage(e);
			}
			log.info("thenAccept end");
		});
		log.info("receiveMessage end");
	}

	/**
	 * 예외 처리
	 * @param tileMessage
	 * @param message
	 */
	private void handlerException(TileMessage tileMessage, String message) {
		//PostProcess.executeException(dataLibraryConverterJob, propertiesConfig, restTemplate);
	}

}
