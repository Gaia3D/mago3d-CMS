package gaia3d.domain.data;

public enum RelationType {

    HORIZONTAL("horizontal"),
    VERTICAL("vertical");

    private final String value;

    RelationType(String value) {
        this.value = value;
    }

    public String getValue() {
        return this.value;
    }
}
