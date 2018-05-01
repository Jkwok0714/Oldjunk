using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class PlatformMover : MonoBehaviour {

	private Vector3 posA;
	private Vector3 posB;
	private Vector3 nextPos;

	//Watch in inspector
	[SerializeField]
	private float speed;

	[SerializeField]
	private Transform childTransform;

	[SerializeField]
	private Transform transformB;

	// Use this for initialization
	void Start () {


		nextPos = posB;
	}

	// Update is called once per frame
	void Update () {

	}

	private void Move() {
		childTransform.localPosition = Vector3.MoveTowards (childTransform.localPosition, nextPos, speed * Time.deltaTime);
	}

}
