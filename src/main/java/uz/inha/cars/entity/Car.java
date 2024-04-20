package uz.inha.cars.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.UUID;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
public class Car {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;
    @NotBlank(message = "please enter the name")
    private String name;
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    private Company company;
    @OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private Attachment photo;
    @OneToMany(cascade = CascadeType.PERSIST)
    private List<CarDetail> carDetails;
}
