package sv.edu.ues.laboratorio3.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import sv.edu.ues.laboratorio3.model.Entrega;

public interface EntregaRepository
        extends JpaRepository<Entrega, String> {
}
