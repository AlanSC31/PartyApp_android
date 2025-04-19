package com.partyapp.gestiondeusuarios.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.partyapp.gestiondeusuarios.model.Card;
import com.partyapp.gestiondeusuarios.repository.CardRepository;

@Service
public class CardService {
   @Autowired
   private CardRepository cardRep;

   public Card registerCard(Card card) {
      Card existingCard = cardRep.findByUid(card.getUid());
  
      if (existingCard != null) {
          existingCard.setNumber(card.getNumber());
          existingCard.setName(card.getName());
          existingCard.setDate(card.getDate());
          existingCard.setCvv(card.getCvv());
  
          return cardRep.save(existingCard); 
      }
  
      return cardRep.save(card);
  }
  

   // card update
   public Card updatedCard(Card updatedCard, String uid ) throws Exception {
      Card card = cardRep.findByUid(uid);

      if (card == null) {
         throw new Exception("card no encontrado");
     }

     card.setName(updatedCard.getName());
     card.setNumber(updatedCard.getNumber());
     card.setDate(updatedCard.getDate());
     card.setCvv(updatedCard.getCvv());
     card.setUid(uid);


     return cardRep.save(updatedCard);
   }

   // card info
   public Card cardInfo(String uid) throws Exception {
    Card card = cardRep.findByUid(uid);

    if(card == null){
        throw new Exception("Tarjeta no encontrado");
    }
    return card;
   }
} 