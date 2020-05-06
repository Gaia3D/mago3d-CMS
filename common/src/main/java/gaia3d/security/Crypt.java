package gaia3d.security;

import org.apache.commons.codec.binary.Base64;

/**
 * PM 솔루션 내 DB 사용자 암/복호화, 사용자 패스워드 암/복호화등에 사용
 * @author jeongdae
 *
 */
public class Crypt {
	private static String INIT_KEY = KeyManager.getInitKey();
	
	// TODO static 변수화 해서 암/복호화 값이 같은지 반드시 확인해 봐야 함
	
	private static final byte[] ZERO_16 = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0A, 0x0C, 0x0E };
    private static final byte[] ZERO_16_FIX = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
    private static final int BYTE_16 = 16;
    
    private Crypt() {
    }

    public static String encrypt(String strNor) {
        if( strNor == null || "".equals(strNor) ) {
        	return "";
        }
        
        int[] m_roundKey = new int[32];
        byte[] m_chunk1 = new byte[BYTE_16];
        byte[] m_chunk2 = new byte[BYTE_16];

        byte[] pbUserKey = INIT_KEY.getBytes();
        byte[] tmpUserKey = new byte[16];

        System.arraycopy(ZERO_16, 0, tmpUserKey, 0, BYTE_16);
        System.arraycopy(pbUserKey, 0, tmpUserKey, 0, pbUserKey.length);
        Seed.SeedEncRoundKey(m_roundKey, tmpUserKey);
        
        byte[] inData = strNor.getBytes();
        byte[] outData = new byte[(inData.length%BYTE_16==0) ? inData.length : (inData.length/BYTE_16+1)*BYTE_16];
        
        int left;
        for(int sp = 0; sp < inData.length; sp += BYTE_16 ) {
        	left = inData.length - sp;
            if( left >= BYTE_16) {
            	System.arraycopy(inData, sp, m_chunk1, 0, BYTE_16);
            } else {
                System.arraycopy(ZERO_16_FIX, 0, m_chunk1, 0, BYTE_16);
                System.arraycopy(inData, sp, m_chunk1, 0, left);
            }
            Seed.SeedEncrypt(m_chunk1, m_roundKey, m_chunk2);
            System.arraycopy(m_chunk2, 0, outData, sp, BYTE_16);
        }

        byte[] base64 = Base64.encodeBase64(outData);
        return new String(base64).trim();
    }

    public static String decrypt(String strEnc) {
    	if( strEnc == null || "".equals(strEnc) ) {
        	return "";
        }
    	
    	int[] m_roundKey = new int[32];
        byte[] m_chunk1 = new byte[BYTE_16];
        byte[] m_chunk2 = new byte[BYTE_16];

        byte[] pbUserKey = INIT_KEY.getBytes();
        byte[] tmpUserKey = new byte[16];

        System.arraycopy(ZERO_16, 0, tmpUserKey, 0, BYTE_16);
        System.arraycopy(pbUserKey, 0, tmpUserKey, 0, pbUserKey.length);
        Seed.SeedEncRoundKey(m_roundKey, tmpUserKey);

        byte[] inData = Base64.decodeBase64(strEnc.getBytes());
        byte[] outData = new byte[(inData.length%BYTE_16==0) ? inData.length : (inData.length/BYTE_16+1)*BYTE_16];
        int left;
        for(int sp = 0; sp < inData.length; sp += BYTE_16 ) {
            left = inData.length - sp;
            if( left >= BYTE_16) {
            	System.arraycopy(inData, sp, m_chunk1, 0, BYTE_16);
            } else {
            	System.arraycopy(ZERO_16_FIX, 0, m_chunk1, 0, BYTE_16);
                System.arraycopy(inData, sp, m_chunk1, 0, left);
            }
            Seed.SeedDecrypt(m_chunk1, m_roundKey, m_chunk2);
            System.arraycopy(m_chunk2, 0, outData, sp, BYTE_16);
        }

        byte[] zeroOutData = outData;
        for(int i = 0; i < outData.length; i++) {
            if(outData[i] == 0x00) {
                zeroOutData = new byte[i];
                System.arraycopy(outData, 0, zeroOutData, 0, i);
                break;
            }
        }

        return new String(zeroOutData);
    }
}
