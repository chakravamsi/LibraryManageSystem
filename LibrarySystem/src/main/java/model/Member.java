package model;

public class Member {
    private int memberId;
    private String name;
    private String contact;
    private String role; // NEW FIELD

    public Member() {}


    public Member(int memberId, String name, String contact) {
        this.memberId = memberId;
        this.name = name;
        this.contact = contact;
        this.role = ""; 
    }

   
    public Member(int memberId, String name, String contact, String role) {
        this.memberId = memberId;
        this.name = name;
        this.contact = contact;
        this.role = role;
    }

    
    public int getMemberId() { return memberId; }
    public void setMemberId(int memberId) { this.memberId = memberId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getContact() { return contact; }
    public void setContact(String contact) { this.contact = contact; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}
