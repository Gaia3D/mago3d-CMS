package com.gaia3d.domain;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class QueueMessage implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6581364684193739905L;
	
	private Long converter_job_id;
	private String input_folder;
	private String output_folder;
	private String mesh_type;
	private String log_path;
	private String indexing;
}
