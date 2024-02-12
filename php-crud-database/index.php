<?php
session_start();

if (!isset($_SESSION['data'])) {
    $_SESSION['data'] = [];
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
	if (isset($_POST['create'])) {
			$newItem = ['id' => uniqid(), 'name' => $_POST['name']];
			$_SESSION['data'][] = $newItem;
	}
	if (isset($_POST['update'])) {
			foreach ($_SESSION['data'] as $key => $item) {
					if ($item['id'] == $_POST['id']) {
							$_SESSION['data'][$key]['name'] = $_POST['name'];
							break;
					}
			}
	}
	if (isset($_POST['delete'])) {
			foreach ($_SESSION['data'] as $key => $item) {
					if ($item['id'] == $_POST['id']) {
							unset($_SESSION['data'][$key]);
							break;
					}
			}
	}
}

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Simple CRUD without Database</title>
</head>
<body>
    <form method="POST">
        <label for="id">ID: </label>
        <input type="text" id="id" name="id" readonly>
        <br>
        <label for="name">Name: </label>
        <input type="text" id="name" name="name">
        <br>
        <button type="submit" id="create" name="create">Create</button>
        <button type="submit" id="update" name="update">Update</button>
        <button type="submit" id="delete" name="delete">Delete</button>
    </form>

    <h2>Data:</h2>
    <ul>
        <?php foreach($_SESSION['data'] as $item): ?>
            <li>
                ID: <?= $item['id'] ?>, Name: <?= $item['name'] ?>
                <button onclick="setData('<?= $item['id'] ?>', '<?= $item['name'] ?>')">Update</button>
                <button onclick="setData('<?= $item['id'] ?>', '')">Delete</button>
            </li>
        <?php endforeach; ?>
    </ul>

    <script>
        function setData(id, name) {
            document.getElementById('id').value = id;
            document.getElementById('name').value = name;
        }
    </script>
</body>
</html>
