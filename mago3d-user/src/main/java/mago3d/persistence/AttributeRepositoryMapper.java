package mago3d.persistence;

import org.springframework.stereotype.Repository;

import mago3d.domain.AttributeRepository;

@Repository
public interface AttributeRepositoryMapper {
	AttributeRepository getDataAttribute(String buildName);
}
