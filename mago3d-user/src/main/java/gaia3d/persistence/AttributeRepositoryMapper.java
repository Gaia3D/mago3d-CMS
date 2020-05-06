package gaia3d.persistence;

import org.springframework.stereotype.Repository;

import gaia3d.domain.AttributeRepository;

@Repository
public interface AttributeRepositoryMapper {
	AttributeRepository getDataAttribute(String buildName);
}
