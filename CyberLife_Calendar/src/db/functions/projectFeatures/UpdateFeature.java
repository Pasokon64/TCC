package db.functions.projectFeatures;

import java.sql.PreparedStatement;
import java.sql.SQLException;

import db.Database;
import db.pojo.LabelDB;

public class UpdateFeature {

    public void finishProject(int cod_project) {

        String sql = "UPDATE PROJETO SET FINALIZADO = 1 WHERE COD_PROJETO = ?";

        try {

            PreparedStatement statement = Database.get_connection().prepareStatement(sql);

            statement.setInt(1, cod_project);
            statement.execute();

        } catch (ClassNotFoundException | SQLException e) {

            e.printStackTrace();
        }
    }

    public void update(LabelDB oldLabel, LabelDB newLabel) {

        String sql = "UPDATE MARCADOR SET NOME_MARCADOR = ? WHERE NOME_MARCADOR = ? AND FK_PROJETO = ?";

        try {

            PreparedStatement statement = Database.get_connection().prepareStatement(sql);

            statement.setString(1, newLabel.getNome_marcador());
            statement.setString(2, oldLabel.getNome_marcador());
            statement.setInt(3, newLabel.getFk_projeto());
            statement.execute();

        } catch (ClassNotFoundException | SQLException e) {

            e.printStackTrace();
        }
    }
}