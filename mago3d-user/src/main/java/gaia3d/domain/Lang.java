package gaia3d.domain;

import java.util.Arrays;

/**
 * 인터셉터에서 stream을 매번 호출 하는건 성능의 문제가 있을거 같아서 만들어만 두고 사용하지 않을 계획
 */
public enum Lang {
    KO("ko", "ko-KR"),
    EN("en", "en-US"),
    JP("ja", "ja-JP");

    private String language;
    private String accessibility;

    Lang(String language, String accessibility) {
        this.language = language;
        this.accessibility = accessibility;
    }

    public String getLanguage() {
        return this.language;
    }

    public String getAccessibility() {
        return this.accessibility;
    }

    /**
     * @param language
     * @return
     */
    public static Lang findByLanguage(String language) {
        return Arrays.stream(values())
                .filter(lang -> lang.getLanguage().equals(language))
                .findAny()
                .orElse(KO);
    }
}
