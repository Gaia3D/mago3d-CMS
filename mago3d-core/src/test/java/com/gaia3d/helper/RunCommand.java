package com.gaia3d.helper;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;

import org.junit.Test;

public class RunCommand {

	@Test
	public void test() {
		String s = null;
		try {
			// run the Unix "ps -ef" command
			Process p = Runtime.getRuntime().exec("ipconfig");
			BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));
			BufferedReader stdError = new BufferedReader(new InputStreamReader(p.getErrorStream()));
			// read the output from the command
			System.out.println("Here is the standard output of the command:\n");
			while ((s = stdInput.readLine()) != null) {
				System.out.println(s);
			}
			// read any errors from the attempted command
			System.out.println("Here is the standard error of the command (if any):\n");
			while ((s = stdError.readLine()) != null) {
				System.out.println(s);
			}

		} catch (IOException e) {
			System.out.println("exception happened - here's what I know: ");
			e.printStackTrace();

		}
	}

	@Test
	public void processBuilder() {
		try {
			ProcessBuilder pb = new ProcessBuilder("java", "-version"); // Execute (with standard input and output)

			File log = new File("error.log");
			// pb.redirectErrorStream(true); // merge output and error streams
			pb.redirectInput(ProcessBuilder.Redirect.from(new File("in.txt")));
			pb.redirectOutput(ProcessBuilder.Redirect.to(new File("out.txt")));
			pb.redirectError(ProcessBuilder.Redirect.appendTo(new File("error.log")));

			Process p = pb.start();
			int exitValue = p.waitFor();
			System.out.println("Process Completed with exit value of " + exitValue);
		} catch (java.io.IOException ex) {
		} catch (InterruptedException ex) {
		}
	}
}
