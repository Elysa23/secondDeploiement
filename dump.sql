-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: laravel
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
INSERT INTO `cache` VALUES ('laravel_cache_zohajaina@xn--xample-hc1c.com|127.0.0.1','i:1;',1747741534),('laravel_cache_zohajaina@xn--xample-hc1c.com|127.0.0.1:timer','i:1747741534;',1747741534);
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_pages`
--

DROP TABLE IF EXISTS `course_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_pages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `course_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_pages_course_id_foreign` (`course_id`),
  CONSTRAINT `course_pages_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_pages`
--

LOCK TABLES `course_pages` WRITE;
/*!40000 ALTER TABLE `course_pages` DISABLE KEYS */;
INSERT INTO `course_pages` VALUES (1,7,'Page 1','🔁 Comment ils travaillent ensemble ?\r\nL’utilisateur accède à une page → une route appelle un contrôleur.\r\n\r\nC\r\nLe contrôleur traite la demande → utilise le modèle pour récupérer ou modifier des données.\r\n\r\n\r\nIl transmet ensuite les données à une vue pour l’affichage.\r\n\r\n\r\nExactement ✅ ! Tu as parfaitement compris :\r\n🔁 Le modèle est l\'intermédiaire entre le contrôleur et la base de données.\r\nVoici une image simple à garder en tête :\r\nUtilisateur (navigateur)\r\n       ↓\r\n    Route\r\n       ↓\r\n  🎮 Contrôleur  ←→  🗄️ Modèle  ←→  💽 Base de données\r\n       ↓\r\n     Vue (HTML affichée)\r\n\r\n🧠 En résumé :\r\nLe contrôleur reçoit la demande.\r\n\r\n\r\nIl demande au modèle d’aller chercher ou modifier des données dans la base de données.\r\n\r\n\r\nIl retourne une vue (HTML) avec les données récupérées.',1,'2025-05-05 08:13:10','2025-05-05 08:17:05');
/*!40000 ALTER TABLE `course_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_progress`
--

DROP TABLE IF EXISTS `course_progress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_progress` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `course_id` bigint(20) unsigned NOT NULL,
  `started_at` timestamp NULL DEFAULT NULL,
  `progress_percent` double DEFAULT NULL,
  `course_page_id` bigint(20) unsigned DEFAULT NULL,
  `status` enum('in_progress','completed') NOT NULL DEFAULT 'in_progress',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_progress_user_id_foreign` (`user_id`),
  KEY `course_progress_course_id_foreign` (`course_id`),
  KEY `course_progress_course_page_id_foreign` (`course_page_id`),
  CONSTRAINT `course_progress_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `course_progress_course_page_id_foreign` FOREIGN KEY (`course_page_id`) REFERENCES `course_pages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `course_progress_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_progress`
--

LOCK TABLES `course_progress` WRITE;
/*!40000 ALTER TABLE `course_progress` DISABLE KEYS */;
INSERT INTO `course_progress` VALUES (1,14,7,'2025-05-12 15:21:11',NULL,1,'in_progress','2025-05-05 09:09:42','2025-05-12 15:21:11'),(2,14,6,'2025-05-13 14:43:57',NULL,NULL,'in_progress','2025-05-12 15:00:15','2025-05-13 14:43:57');
/*!40000 ALTER TABLE `course_progress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `status` enum('draft','published','archived') NOT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `attachment` varchar(255) DEFAULT NULL,
  `video` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `courses_teacher_id_foreign` (`user_id`),
  CONSTRAINT `courses_teacher_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES (6,'Cours 2','Ce cours concerne Laravel.',13,'published','thumbnails/mZyVmATHqpWRfPJ8M7raenxfe0hQ8NH70C24DMUM.jpg',120,'2025-05-02 14:01:53','2025-05-02 15:20:20','Parfait ! Voici une fiche de révision synthétique sur ce que tu dois absolument assimiler pour bien comprendre Laravel et le backend d’authentification que tu viens de mettre en place avec Laravel Breeze.\r\n\r\n✅ FICHE ESSENTIELLE – Laravel & Authentification (niveau débutant backend)\r\n\r\n🧱 Laravel – Les bases à retenir\r\n📌 Laravel, c’est quoi ?\r\nFramework PHP backend basé sur le modèle MVC (Modèle – Vue – Contrôleur)\r\n\r\n\r\nFournit des outils puissants pour :\r\n\r\n\r\nGérer les routes (URL → action à effectuer)\r\n\r\n\r\nConnecter une base de données\r\n\r\n\r\nCréer des interfaces utilisateurs (vues)\r\n\r\n\r\nGérer les utilisateurs (authentification, rôles, permissions)\r\n\r\n\r\n\r\n📂 Structure typique (à connaître) :\r\nDossier / Fichier\r\nRôle\r\nroutes/web.php\r\nDéfinit les routes accessibles dans l\'app\r\napp/Http/Controllers\r\nContient les contrôleurs\r\nresources/views\r\nContient les vues HTML (Blade)\r\ndatabase/migrations\r\nContient les fichiers pour créer les tables\r\napp/Models\r\nContient les modèles (ex: User)\r\n.env\r\nFichier de configuration (BDD, APP_URL, etc.)',NULL,NULL),(7,'Cours 3','Ce cours concerne les contrôleurs et les vues dans Laravel.',13,'published','thumbnails/UBxxjQrfvH2JGyyOfYfZU6uZkI79VglO7gyBTsVH.jpg',60,'2025-05-05 07:24:56','2025-05-05 08:18:55','ÉTAPE 5 : Contrôleurs pour la navigation et la progression\r\n\r\n### 5.1. **But de l’étape**\r\n- Permettre à l’apprenant de consulter un cours page par page.\r\n- Enregistrer et retrouver la progression de l’apprenant.\r\n\r\n---\r\n\r\n### 5.2. **Fichiers à modifier/créer**\r\n- `app/Http/Controllers/CourseController.php` (on va ajouter des méthodes)\r\n- (Optionnel) Créer un contrôleur dédié, par exemple `CoursePageController.php` si tu veux séparer la logique.\r\n\r\n---\r\n\r\n### 5.3. **Méthode pour afficher une page de cours**\r\n\r\nDans `CourseController.php` (ou un nouveau contrôleur), ajoute :\r\n\r\n```php\r\nuse App\\Models\\Course;\r\nuse App\\Models\\CoursePage;\r\nuse App\\Models\\CourseProgress;\r\nuse Illuminate\\Support\\Facades\\Auth;\r\n\r\n// ...\r\n\r\n// Afficher une page précise d’un cours\r\npublic function showPage($course_id, $page_id = null)\r\n{\r\n    $course = Course::findOrFail($course_id);\r\n\r\n    // Si aucune page précisée, on prend la première\r\n    if ($page_id) {\r\n        $page = CoursePage::where(\'course_id\', $course_id)->findOrFail($page_id);\r\n    } else {\r\n        $page = $course->pages()->first();\r\n    }\r\n\r\n    // Enregistrer la progression de l’apprenant\r\n    if (Auth::check() && Auth::user()->role === \'apprenant\') {\r\n        CourseProgress::updateOrCreate(\r\n            [\r\n                \'user_id\' => Auth::id(),\r\n                \'course_id\' => $course_id,\r\n            ],\r\n            [\r\n                \'course_page_id\' => $page->id,\r\n                \'status\' => \'in_progress\',\r\n            ]\r\n        );\r\n    }',NULL,NULL),(9,'Cours 4','Ce cours concerne les modèles et les contrôleurs.',13,'archived','thumbnails/D7fU632ywww72XxxR2Llw7DuDKNNoXuzoSlSdfcP.jpg',60,'2025-05-05 07:36:36','2025-05-05 10:01:08','🌱 1. Modèle (Model)\r\nUn modèle représente les données et la logique métier.\r\n Dans Laravel, un modèle est une classe PHP qui correspond à une table dans la base de données.\r\n➤ Exemple :\r\nclass User extends Model\r\n{\r\n    // Laravel sait que ce modèle est lié à la table \"users\"\r\n}\r\n\r\nSi tu fais une requête comme User::all(), Laravel va chercher tous les utilisateurs dans la table users.\r\n✅ Le modèle sert à :\r\nInteragir avec la base de données (lecture, écriture, mise à jour, suppression).\r\n\r\n\r\nReprésenter une \"entité\" métier (un utilisateur, un produit, un cours...).\r\n\r\n\r\nGérer les relations (ex : un utilisateur a plusieurs commandes).\r\n\r\n\r\n\r\n⚙️ 2. Contrôleur (Controller)\r\nUn contrôleur traite les requêtes utilisateur (comme cliquer sur un bouton ou envoyer un formulaire) et coordonne la réponse à envoyer (une vue, une redirection, etc.).\r\n➤ Exemple :\r\nclass UserController extends Controller\r\n{\r\n    public function index()\r\n    {\r\n        $users = User::all(); // ← appel au modèle\r\n        return view(\'users.index\', compact(\'users\')); // ← renvoie une vue\r\n    }\r\n}\r\n\r\n✅ Le contrôleur sert à :\r\nRecevoir les actions de l’utilisateur.\r\n\r\n\r\nAppeler le modèle si besoin.\r\n\r\n\r\nRetourner une vue avec des données.\r\n\r\n\r\n\r\n🎯 Résumé en tableau\r\nÉlément\r\nRôle principal\r\nExemple concret\r\nModèle\r\nReprésente les données\r\nUser::create([...]), User::where(...)\r\nContrôleur\r\nGère la logique de traitement\r\nUserController@index() → affiche la liste',NULL,NULL);
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(5,'2025_04_28_152037_add_role_to_users_table',2),(6,'2025_04_28_160235_add_role_to_users_table',3),(7,'2025_05_01_121804_create_courses_table',4),(8,'2025_05_02_112931_add_content_and_files_to_courses_table',5),(9,'2025_05_02_125155_add_content_and_files_to_courses_table_v2',6),(10,'2025_05_05_073948_create_course_pages_table',7),(11,'2025_05_05_074838_create_course_progress_table',7),(12,'2025_05_06_152701_create_quizzes_table',8),(13,'2025_05_08_170727_create_quiz_answers_table',9),(14,'2025_05_12_115454_rename_teacher_id_to_user_id_in_courses_table',10),(15,'2025_05_12_140014_add_started_at_to_course_progress_table',11),(16,'2025_05_13_072136_add_progress_percent_to_course_progress_table',12),(17,'2025_05_13_115636_create_quiz_results_table',13),(18,'2025_05_13_130812_add_score_to_quiz_answers_table',14),(19,'2025_05_13_172228_add_passing_score_to_quizzes_table',15),(21,'2025_05_19_121520_add_title_to_quizzes_table',16),(22,'2025_05_20_091331_add_profile_fields_to_users_table',17);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz_answers`
--

DROP TABLE IF EXISTS `quiz_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quiz_answers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `quiz_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `answers` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`answers`)),
  `score` double DEFAULT NULL,
  `time_spent` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `quiz_answers_quiz_id_foreign` (`quiz_id`),
  KEY `quiz_answers_user_id_foreign` (`user_id`),
  CONSTRAINT `quiz_answers_quiz_id_foreign` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `quiz_answers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz_answers`
--

LOCK TABLES `quiz_answers` WRITE;
/*!40000 ALTER TABLE `quiz_answers` DISABLE KEYS */;
INSERT INTO `quiz_answers` VALUES (1,25,14,'[\"Je ne sais pas\"]',NULL,NULL,'2025-05-09 14:03:42','2025-05-09 14:03:42'),(2,9,14,'[\"1\",\"0\"]',NULL,NULL,'2025-05-09 14:06:49','2025-05-09 14:06:49'),(3,28,14,'[\"0\",\"1\",\"1\",\"0\",\"0\",\"0\",\"1\",\"1\"]',NULL,NULL,'2025-05-09 14:54:06','2025-05-09 14:54:06'),(4,28,14,'[\"1\",\"4\",\"2\",\"1\",\"2\",\"1\",\"0\",\"0\"]',NULL,NULL,'2025-05-10 10:14:00','2025-05-10 10:14:00'),(5,28,14,'[\"1\",\"2\",\"2\",\"1\",\"1\",\"0\",\"1\",\"1\"]',NULL,NULL,'2025-05-13 12:30:15','2025-05-13 12:30:15'),(6,9,14,'[\"1\",\"0\"]',NULL,NULL,'2025-05-15 10:09:08','2025-05-15 10:09:08'),(8,9,14,'\"[\\\"1\\\",\\\"0\\\"]\"',75,NULL,'2025-05-15 11:25:26','2025-05-15 11:25:26'),(10,9,14,'[\"0\",\"1\"]',NULL,NULL,'2025-05-15 11:35:28','2025-05-15 11:35:28'),(11,9,14,'[\"0\",\"0\"]',NULL,NULL,'2025-05-15 11:37:28','2025-05-15 11:37:28'),(12,9,14,'[\"1\",\"0\"]',NULL,NULL,'2025-05-15 11:38:16','2025-05-15 11:38:16'),(13,9,14,'[\"0\",\"1\"]',NULL,NULL,'2025-05-15 11:44:17','2025-05-15 11:44:17'),(14,9,14,'[\"2\",\"0\"]',NULL,NULL,'2025-05-15 11:47:49','2025-05-15 11:47:49'),(15,9,14,'[\"2\",\"0\"]',NULL,NULL,'2025-05-15 11:54:31','2025-05-15 11:54:31'),(16,28,14,'[\"0\",\"1\",\"1\",\"2\",\"2\",\"0\",\"0\",\"1\"]',NULL,NULL,'2025-05-19 10:11:07','2025-05-19 10:11:07'),(17,9,14,'[\"1\",\"0\"]',NULL,NULL,'2025-05-20 10:40:10','2025-05-20 10:40:10');
/*!40000 ALTER TABLE `quiz_answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quiz_results`
--

DROP TABLE IF EXISTS `quiz_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quiz_results` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `quiz_id` bigint(20) unsigned NOT NULL,
  `score` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `quiz_results_user_id_foreign` (`user_id`),
  KEY `quiz_results_quiz_id_foreign` (`quiz_id`),
  CONSTRAINT `quiz_results_quiz_id_foreign` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `quiz_results_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quiz_results`
--

LOCK TABLES `quiz_results` WRITE;
/*!40000 ALTER TABLE `quiz_results` DISABLE KEYS */;
/*!40000 ALTER TABLE `quiz_results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quizzes`
--

DROP TABLE IF EXISTS `quizzes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quizzes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `course_id` bigint(20) unsigned NOT NULL,
  `passing_score` double NOT NULL DEFAULT 50,
  `user_id` bigint(20) unsigned NOT NULL,
  `content` longtext NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `quizzes_course_id_foreign` (`course_id`),
  KEY `quizzes_user_id_foreign` (`user_id`),
  CONSTRAINT `quizzes_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `quizzes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quizzes`
--

LOCK TABLES `quizzes` WRITE;
/*!40000 ALTER TABLE `quizzes` DISABLE KEYS */;
INSERT INTO `quizzes` VALUES (9,'',7,50,2,'# Titre du quiz\r\n\r\n**Question 1 :**  \r\nQuel est le résultat de 2 + 2 ?\r\n\r\n- [ ] 3\r\n- [x] 4\r\n- [ ] 5\r\n\r\n---\r\n\r\n**Question 2 :**  \r\nCoche la bonne réponse.\r\n\r\n- [x] Vrai\r\n- [ ] Faux','2025-05-07 13:59:28','2025-05-08 14:14:32'),(12,'',7,50,2,'# Quiz sur le PHP\r\n\r\n   **Question 1 :**  \r\n   Quel mot-clé permet de définir une fonction ?\r\n\r\n   - [ ] class\r\n   - [x] function\r\n   - [ ] var\r\n\r\n   ---\r\n   **Question 2 :**  \r\n   Le PHP est-il typé dynamiquement ?\r\n\r\n   - [x] Oui\r\n   - [ ] Non','2025-05-07 14:22:51','2025-05-08 14:22:48'),(25,'',6,50,2,'3. Propriété de base de l’OO\r\n3.1- L’héritage\r\nL\'héritage permet de spécialiser une classe qui possédera non seulement les\r\npropriétés et méthodes de sa mère mais également d\'autres méthodes spécifiques ou\r\nredéfinies. Le terme est faire dériver la classe en une classe fille. Dans l\'objet fille, on trouve:\r\n- De nouvelles méthodes ou propriétés\r\n- Des méthodes ou propriétés qui surchargent, c\'est-à -dire redéfinissent celles\r\nde la classe mère.\r\nRemarque:\r\nLes méthodes et propriétés peuvent être héritées à un niveau n, c\'est-à-dire qu\'un\r\nobjet peut utiliser une méthode de la mère de sa mère et ainsi de suite.\r\n3.2- Polymorphisme et Transtypage\r\nLes objets sont dits polymorphes car ils possèdent plusieurs types: le type de leurs\r\nclasses et les types des classes ascendantes. Par exemple, une Honda, instance de Moto aura\r\ncomme type initial Moto mais une Moto possède par héritage le type Véhicule. L\'objet une\r\nHonda est bien un Véhicule. Dans certains cas, il est possible de forcer le programme à \'voir\' un\r\nobjet comme un type différent de son type initial, c\'est le transtypage ou cast. Ce transtypage\r\nne modifie pas l\'objet mais indique seulement la façon de le voir. Il y a transtypage implicite de','2025-05-08 14:31:56','2025-05-09 14:29:01'),(28,'',6,50,2,'### Laravel & Authentification (niveau débutant backend)\n\n#### 🧱 Laravel – Les bases à retenir\n\n**Quelle est la définition de Laravel ?**\n- ( ) Framework PHP frontend basé sur le modèle MVC\n- [x] Framework PHP backend basé sur le modèle MVC (Modèle – Vue – Contrôleur)\n---\n#### Les outils fournis par Laravel\n\n**Que gère Laravel pour les des notre appliscation ?**\n- ( ) Gérer le frontend\n- [x] Gérer les routes (URL → action à effectuer)\n- [x] Connecter une base de données\n- [x] Créer des interfaces utilisateurs (vues)\n- [x] Gérer les utilisateurs (authentification, rôles, permissions)\n---\n#### Structure typique de Laravel (à connaître)\n\n**Où trouver les fichiers de définition des routes dans Laravel ?**\n- ( ) routes/frontend.php\n- ( ) resources/routes/web.php\n- [x] routes/web.php - Définit les routes accessibles dans l\'app\n---\n**Où trouver les contrôleurs dans Laravel ?**\n- ( ) routes/controllers/\n- ( ) app/Http/Frontend/Controllers/\n- [x] app/Http/Controllers/ - Contient les contrôleurs\n---\n**Où trouver les fichiers pour créer les tables dans Laravel ?**\n- ( ) database/routes/\n- ( ) app/Models/\n- [x] database/migrations/ - Contient les fichiers pour créer les tables\n---\n**Où trouver les fichiers des interfaces utilisateurs (vues) HTML (Blade) dans Laravel ?**\n- ( ) app/resources/routes/web.Blade.php\n- [x] resources/views/ - Contient les vues HTML (Blade)\n---\n**Où trouver les fichiers des models (qui correspondent aux tables de la base de données) dans Laravel ?**\n- ( ) database/models/\n- [x] app/Models/ - Contient les modèles (ex: User)\n---\n**Ce fichier est utilisé pour les paramètres de la base de données et d\'autres configurations générales ?**\n- ( ) .controllers/\n- [x] .env - Fichier de configuration (BDD, APP_URL, etc.)','2025-05-09 14:31:12','2025-05-09 14:31:12'),(34,'',6,50,2,'------\n**Quiz : Laravel & Authentification (niveau débutant backend)**\n\n🧩 Laravel - Les points à retenir   description: Aussi connu comme Framework PHP backend, il est basé sur le modèle MVC (Modèle – Vue – Contrôleur). Il fournit des outils puissants pour gérer les routes, se connecter à une base de données, créer des interfaces utilisateurs (vue), gérer les utilisateurs (authentification, rôles, permissions).\n\n1. Qu\'est-ce qui est défini dans le fichier routes/web.php pour l\'application ?\n    - A. Les routes SQL\n    - B. Les fichiers pour gérer les utilisateurs\n    - C. Les routes accessibles dans l\'application\n    - D. La base de données\n    - E. Les contenus des e-mails\n\n   [C] Les routes accessibles dans l\'application\n\n---\n\n2. Quelques dossiers et fichiers sont nécessaires pour créer des interfaces utilisateurs (vues) dans Laravel ?\n    - A. routes/web.php, app/Http/Controllers, resources/views\n    - B. database/migrations, app/Models, app/Models/Users\n    - C. .env, app/Http/Kernel, app/View/Users\n    - D. model, database, views, users.blade.php\n    - E. routes/web.php, resources/views/Users, app/Models/Users\n\n   [A] routes/web.php, app/Http/Controllers, resources/views\n\n---\n\n3. Combien de dossiers sont-ils présents dans une structure typique de Laravel ?\n    - A. Un\n    - B. Deux\n    - C. Trois\n    - D. Quatre\n    - E. Cinq\n\n   [D] Quatre\n\n---\n\n4. Quel est le rôle du fichier .env ?\n    - A. Définit les routes GitHub\n    - B. Définit les fichiers pour créer les tables\n    - C. Définit les logs des erreurs à afficher lors d\'un dépannage\n    - D. Fichier de configuration, il permet notamment de définir les informations de connexion à la base de données, l\'URL de l\'application, les clefs Oil-key, les variables de plateforme, etc.\n    - E. Définit les informations de connexion à la banque\n\n   [D] Fichier de configuration, il permet notamment de définir les informations de connexion à la base de données, l\'URL de l\'application, les clefs OAuth, les variables de plateforme, etc.','2025-05-19 09:33:36','2025-05-19 09:33:36'),(35,'',7,50,2,'// Afficher la page & enregistrer dans le bufferlehtml view\n    return view($page->template, compact(\'page\', \'course\'));\n}\n```\n\n---\n\n### 5.4. **Méthode pour suivre la progression de l’apprenant**\n\nDans `CourseController.php`, ajoute :\n```php\n// ...\n\n// Afficher la progression de l’apprenant pour un cours\npublic function progress($course_id)\n{\n    $progress = CourseProgress::where([\n        \'user_id\' => Auth::id(),\n        \'course_id\' => $course_id\n    ])->orderBy(\'course_page_id\')->first();\n\n    if (!isset($progress->course_page_id)) {\n        return redirect()->route(\'courses.view\', [\'id\' => $course_id]);\n    }\n\n    $nextPageId = $progress->course_page_id + 1;\n    $currentPage = CoursePage::where(\'course_id\', $course_id)->where(\'id\', $progress->course_page_id)->first();\n    $nextPage = (!is_null($nextPageId)) ? CoursePage::where(\'course_id\', $course_id)->where(\'id\', $nextPageId)->first() : null;\n\n    return view(\'course-progress\', compact(\'currentPage\', \'nextPage\', \'course_id\', \'progress\'));\n}\n```\n\n---\n\n### 5.5. **Quelques questions pour l’examen (QCM)**\n\n1. **Quel contrôleur doit regrouper les méthodes pour gérer la progression de l\'apprenant ?**\n   - `UserController.php`\n   - `CourseController.php`\n   - `ProgressController.php`\n   - `StudentController.php`\n   - `NavigationController.php`\n   - **`CourseController.php`**\n\n2. **Comment appelle-t-on une page de cours dans Laravel?**\n   - `Course::find($id)`\n   - **`CoursePage::find($id)`**\n   - `CourseDisplay::find($id)`\n   - `CoursePage::get($id)`\n   - `CoursePageInstance::find($id)`\n\n3. **Quels éléments sont nécessaires dans un formulaire de création d\'une page de cours ?**\n   - `_\\_token`, `method` et `route`\n   - `course_id`, `page_title`, `page_content`\n   - `\\_\\_token`, `course_id`, `page_title`, `page_content`, `method`, `route`\n   - `course_id`, `template`, `content`\n   - Tous les éléments de la proposition 3 et `page_title` est facultatif\n   - **`course_id`, `page_title`, `page_content`, `method`, `route`,`template`, `content`**\n\n4. **Dans quelle méthode du contrôleur de cours appelée pour afficher une page spécifique ?**\n   - `create()`\n   - **`show()`**\n   - `edit()`\n   - `store()`\n   - `index()`\n   - `update()`\n\n5. **Quel attribut de la collection `$page` donne l\'ID de la page actuelle ?**\n   - `title`\n   - `id`\n   - **`CoursId`**\n   - `pages`\n   - `content`\n   - `course`','2025-05-19 14:06:40','2025-05-19 14:06:40'),(36,'',9,50,2,'## Quiz sur le contrôleur (Controller) et le modèle (Model) dans Laravel\n\n#### Q1. **Qu\'est-ce qu\'un modèle?**\n- Un modèle représente les données et la logique métier\n- Un modèle représente la base de données\n- Un modèle représente l\'interface utilisateur\n- Un modèle représente l\'environnement de développement\n\n[x] - Un modèle représente les données et la logique métier\n\n#### Q2. **Que fait Laravel quand tu fais une requête comme User::all() ?**\n- Laravel va chercher tous les utilisateurs dans la table \"web\"\n- Laravel va chercher tous les utilisateurs dans la table \"users\"\n- Laravel va chercher tous les utilisateurs dans la table \"database\"\n- Laravel va chercher tous les utilisateurs dans la table \"tableaux\"\n\n[x] - Laravel va chercher tous les utilisateurs dans la table \"users\"\n\n#### Q3. **Dans quel cas utilisera-t-on un contrôleur?**\n- Lorsque l\'utilisateur clique sur un bouton\n- Lorsque l\'utilisateur envoie un formulaire\n- Lorsque l\'utilisateur recherche les données\n- Lorsque l\'utilisateur lit les données\n\n[x] - Lorsque l\'utilisateur clique sur un bouton\n\n#### Q4. **Que fait le contrôleur lorsqu\'il est appelé?**\n- Il appelle le modèle si besoin\n- Il gère les données\n- Il gère l\'interface utilisateur\n- Il gère le système d\'exploitation\n\n[x] - Il appelle le modèle si besoin\n\n#### Q5. **Qu\'est-ce que la méthode index de UserController va faire?** (Assume you have an action that list users)\n- Elle affiche la page d\'accueil\n- Elle comptabilise les utilisateurs\n- Elle affiche la liste des utilisateurs\n- Elle ajoute un nouvel utilisateur\n\n[x] Elle affiche la liste des utilisateurs\n\n### Résumé\n\n| Élément       | Rôle principal   | Exemple concret                      |\n|---------------|----------------|-------------------------------------|\n| Modèle        | Représente les données          | User::create([...]), User::where(...)|\n| Contrôleur    | Gère la logique de traitement    | UserController@index()              |','2025-05-19 14:22:26','2025-05-19 14:22:26');
/*!40000 ALTER TABLE `quizzes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('0pt9j7hXbL3WO3RPDC3XPYxRJQKkhRfQI9XDWpq2',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiUmxHYm4zR2gwM0NtTXo2RFJNSmxtWHdBSllJOFZWZkM3VzV0cnJsMyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1747926083),('DMpWZyKLcY9QG30m4YLsrGGpRkVqQxMoZFvCvRdf',2,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36','YTo0OntzOjY6Il90b2tlbiI7czo0MDoiUmZLQ1pERTVwV0s2Z1RvOTJtVHRuckVicWJNOHJKZzc1anVTb0Q1ciI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9xdWl6emVzIjt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6Mjt9',1747928568),('f2waB76Kqdf7GXKlMfWYSsIF2ek10f8uzzyqNwSM',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoieTZ0bnhDSkNVYmlFV05rRE9XQVN4UFZHazBrcGtGSmZPMnRPRGpiRCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hcHByZW5hbnQvY291cnMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19',1747926077);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `profile_photo_path` varchar(2048) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `role` varchar(255) DEFAULT 'apprenant',
  `project_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (2,'Ely Nounours',NULL,NULL,'nambinintsoaelysa3@gmail.com',NULL,'$2y$12$nK6ikR2NY42i3ZXGihTIQeQyCzH1s1DRs7Zf7ogU/u8KYOSVJOBEG','profile-photos/tveXeQUnlL0Ntza9rjqdBwHOt4HZCNAkkGC3Lvw3.jpg',NULL,'2025-04-28 15:21:01','2025-05-22 12:47:12','admin',NULL),(10,'Elysa Nambinintsoa',NULL,NULL,'elyNam@example.com',NULL,'$2y$12$Z5RQge0EHdQ4Nfw2KbCVcOz5FWWzMJ/YSKBbvdtB/KkDd/8Kr9sW.',NULL,NULL,'2025-04-30 09:39:08','2025-04-30 09:39:08','apprenant',NULL),(11,'Helena',NULL,NULL,'helena@example.com',NULL,'$2y$12$oyUJVoFUbS//KkhZAuYeYuFc8CkAfv6geYpsh4bExaWih6zFcXgsm',NULL,NULL,'2025-05-01 07:09:04','2025-05-01 07:09:04','formateur',NULL),(12,'Moi Test',NULL,NULL,'moi@example.com',NULL,'$2y$12$IwqTjPORy5Gr4rArUWZMNufNxRtm6VAr3OhlEcAOfiSshUfVsRlxm',NULL,NULL,'2025-05-01 07:28:15','2025-05-01 07:30:42','apprenant',NULL),(13,'Zo Hajaina',NULL,NULL,'zohajaina@example.com',NULL,'$2y$12$MlHUwfCpdgvof/U1cliLrOL8ICurHO.hyUH65aWgxzh4pMPnYmMKy','profile-photos/6KXqTUe5uI00lX1ytv5fPVig0dqtPiX10Cs4gDB1.jpg',NULL,'2025-05-01 11:14:52','2025-05-20 10:27:23','formateur',NULL),(14,'Test User',NULL,NULL,'testuser@example.com',NULL,'$2y$12$IxOf5oaMxxfk0kGXYZO8T.9ot0.YgZdI6z4H6sCt6UDHKUYL4nv9a','profile-photos/MVm5rUGxqHlVOIK3zgMi08qYMZKys5x4QDPvYTBO.jpg',NULL,'2025-05-02 15:41:26','2025-05-20 09:45:55','apprenant',NULL),(15,'Ted',NULL,NULL,'justeted@exemple.com',NULL,'$2y$12$MCwMp4qDCMmq6KEtD3uCM.pwh3oEz/c3rdRy2VkPnnrKD.MsSFMa2',NULL,NULL,'2025-05-10 10:07:24','2025-05-10 10:07:24','formateur',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-22 19:11:56
