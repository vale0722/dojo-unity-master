using UnityEngine;

public class Cubo : MonoBehaviour
{

    public bool movimientoActivado;
    public Vector3 vector;
    public float speedX;
    public float speedY;
    public float speedZ;

    void Start()
    {
        movimientoActivado = false;
    }

    void Update()
    {
        
        if(movimientoActivado)
        {
            if(speedX > 200)
            {
                speedX = 200;
            }
            else if (speedX < 0)
            {
                speedX = 0;
            }

            if (speedY > 200)
            {
                speedY = 200;
            }
            else if (speedY < 0)
            {
                speedY = 0;
            }

            if (speedZ > 200)
            {
                speedZ = 200;
            }
            else if (speedZ < 0) 
            {
                speedZ = 0;
            }

            vector = new Vector3(speedX * Time.deltaTime, speedY * Time.deltaTime, speedZ * Time.deltaTime);
            transform.Rotate(vector, Space.Self);
        }
    }
    public void CambiarEstadoMovimiento(string message)
    {
        bool value = bool.Parse(message);

        movimientoActivado = value;
    }

    public void AumentarVelocidadX(string message)
    {
        float value = float.Parse(message);
        speedX = speedX + value;

    }
    public void AumentarVelocidadY(string message)
    {
        float value = float.Parse(message);

        speedY = speedX + value;

    }
    public void AumentarVelocidadZ(string message)
    {
        float value = float.Parse(message);

        speedZ = speedX + value;
    }

    public void MermarVelocidadX(string message)
    {
        float value = float.Parse(message);
        speedX = speedX - value;

    }
    public void MermarVelocidadY(string message)
    {
        float value = float.Parse(message);

        speedY = speedX - value;

    }
    public void MermarVelocidadZ(string message)
    {
        float value = float.Parse(message);

        speedZ = speedX - value;
    }
}
