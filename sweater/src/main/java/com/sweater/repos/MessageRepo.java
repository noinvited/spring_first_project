package com.sweater.repos;

import com.sweater.domain.Message;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface MessageRepo extends CrudRepository<Message, Long> {
    List<Message> findByTag(String tag);

    @Modifying
    @Query(value = "DELETE FROM Message WHERE id = ?1", nativeQuery = true)
    void deleteById(Long id);
}