package com.uni.c02015.persistence.repository;

import com.uni.c02015.domain.Searcher;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface SearcherRepository extends CrudRepository<Searcher, Integer> {

  Searcher findById(Integer id);
  
  List<Searcher> findByBuddyPref(boolean pref);
  
}