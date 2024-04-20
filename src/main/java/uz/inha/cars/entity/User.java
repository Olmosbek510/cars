package uz.inha.cars.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import uz.inha.cars.entity.enums.RoleName;

import java.util.List;
import java.util.UUID;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;
    private String firstName;
    private String lastName;
    @NotBlank
    private String phone;
    @NotBlank
    @Size(min = 8)
    private String password;
    @ManyToMany
    private List<Role> roles;
    @OneToOne(fetch = FetchType.LAZY)
    private Attachment profilePhoto;

    public boolean hasRole(RoleName roleName) {
        return roles.stream().anyMatch(role -> role.getRoleName().equals(roleName));
    }
}
