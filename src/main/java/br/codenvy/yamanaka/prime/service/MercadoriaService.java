package br.codenvy.yamanaka.prime.service;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import br.codenvy.yamanaka.prime.model.Mercadoria;

/**
 * Componente EJB que define as operações de negócio da entidade <code>Mercadoria</code>.
 * 
 * <p>Herda <code>AbstractPersistence</code> para resolver as operações básicas da persistência de <code>Mercadoria</code>.</p>
 * 
 * @author YaW Tecnologia
 */
@Stateless
public class MercadoriaService extends AbstractPersistence<Mercadoria, Long>{

        /**
         * O container injeta a referência para o <code>EntityManager</code>.
         */
        @PersistenceContext
        private EntityManager em;
        
        @Override
        protected EntityManager getEntityManager() {
                return em;
        }
        
        public MercadoriaService() {
                super(Mercadoria.class);
        }

}
