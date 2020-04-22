package mago3d.service.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import mago3d.domain.AttributeRepository;
import mago3d.persistence.AttributeRepositoryMapper;
import mago3d.service.AttributeRepositoryService;

@AllArgsConstructor
@Service
public class AttributeRepositoryServiceImpl implements AttributeRepositoryService {
	
	private final AttributeRepositoryMapper attributeRepositoryMapper;
	
	@Transactional(readOnly=true)
	public AttributeRepository getDataAttribute(String buildName) {
		return attributeRepositoryMapper.getDataAttribute(buildName);
	}
	
}
