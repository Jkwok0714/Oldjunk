using UnityEngine;
using System.Collections;
using UnityEngine.SceneManagement;

public class Reset : MonoBehaviour {

	// Use this for initialization
	void Start () {

	}

	// Update is called once per frame
	void Update () {

	}

	void OnTriggerEnter2D (Collider2D other)
	{
		if (other.gameObject.CompareTag ("Player")) {
			Scene scene = SceneManager.GetActiveScene ();
			SceneManager.LoadScene (scene.name);
			//SceneManager.LoadScene (SceneManager.GetActiveScene);
			//Application.LoadLevel(Application.loadedLevel);
		} else if (other.gameObject.CompareTag ("Enemy")) {
			Destroy (other.gameObject);
		}
	}
}