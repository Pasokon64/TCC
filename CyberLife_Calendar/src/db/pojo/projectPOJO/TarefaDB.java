package db.pojo.projectPOJO;

public class TarefaDB {

    private int cod_tarefa;
    private String nome_tarefa;
    private int fk_tarefa;

    /**
     * @return the cod_tarefa
     */
    public int getCod_tarefa() {
        return cod_tarefa;
    }

    /**
     * @param cod_tarefa the cod_tarefa to set
     */
    public void setCod_tarefa(int cod_tarefa) {
        this.cod_tarefa = cod_tarefa;
    }

    /**
     * @return the nome_tarefa
     */
    public String getNome_tarefa() {
        return nome_tarefa;
    }

    /**
     * @param nome_tarefa the nome_tarefa to set
     */
    public void setNome_tarefa(String nome_tarefa) {
        this.nome_tarefa = nome_tarefa;
    }

    /**
     * @return the fk_tarefa
     */
    public int getFk_tarefa() {
        return fk_tarefa;
    }

    /**
     * @param fk_tarefa the fk_tarefa to set
     */
    public void setFk_tarefa(int fk_tarefa) {
        this.fk_tarefa = fk_tarefa;
    }

}