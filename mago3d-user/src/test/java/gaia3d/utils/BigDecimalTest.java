package gaia3d.utils;

import java.math.BigDecimal;

import org.junit.jupiter.api.Test;

import lombok.extern.slf4j.Slf4j;

@Slf4j
class BigDecimalTest {

	@Test
	void test() {
		BigDecimal number1 = new BigDecimal("127.74379405054054030");
		BigDecimal number2 = new BigDecimal("12.3000");
		
		log.info("------------- number1 = {}, number2 = {}", number1.longValue(), number2.longValue());
	}
}
