Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2709B12A669
	for <lists+linux-sctp@lfdr.de>; Wed, 25 Dec 2019 07:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbfLYGdK (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 25 Dec 2019 01:33:10 -0500
Received: from mail01.vodafone.es ([217.130.24.71]:59878 "EHLO
        mail01.vodafone.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfLYGdK (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 25 Dec 2019 01:33:10 -0500
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Dec 2019 01:33:08 EST
IronPort-SDR: 7CKg4fV4+DzA4lSx6TK9cMhaImaQbFlL68w5Ox/5cGksyJEEEHYbrHlIWGhgoKgOEEsiYMsAtk
 LCqpacOXazkQ==
IronPort-PHdr: =?us-ascii?q?9a23=3A3zu18BT3wJgUrCh5knpSEWlAqdpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6yZRWN2/xhgRfzUJnB7Loc0qyK6vumAzZbqsrR+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLqMUan4VvJqk+xx?=
 =?us-ascii?q?bKv3BFZ/lYyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7ULJVEi0oP3?=
 =?us-ascii?q?g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RT?=
 =?us-ascii?q?Gv5LplRRP0lCsKMSMy/WfKgcJyka1bugqsqRJ/zY7Ofo+bN+dwcazBct0VXm?=
 =?us-ascii?q?dBQsRcWDBdDo+gc4cDEewMNvtYoYnnoFsOqAOzCw+2C+jy0DFInH723ag70+?=
 =?us-ascii?q?Q9EAHGwhYvFM8JvXTIsdX1MLsdUeGow6bS1jXOdPZW1i386IjMaBwhve+DXb?=
 =?us-ascii?q?ZufsrJ00YgCxnJjk2MqYH8OT6ey+cDs3CD4uZ+SO6iiXQrpxx/rzSz3MsglI?=
 =?us-ascii?q?bEipgbx13E8yhy3Zw7KseiSEFhZN6pCJ5QtyaHOIRoWs4iWGRouDoiyr0BpJ?=
 =?us-ascii?q?67YDAGyJQ5yB7bbPyKa42I7QjiVOaVOzd3mnZldK6wihqo70igzfDzWdO60F?=
 =?us-ascii?q?ZNqCpKjMPAuW4W1xDL68iHTOVy/lu51DqRygze6PtILV06mKbHMZIt3LE9mo?=
 =?us-ascii?q?AdvEnDBiP2nV/5jK6SdkUq4Oio7OHnb636pp+BM497lgD+Pbk0lcykGuk4Nx?=
 =?us-ascii?q?IBX2mf+eimyL3s40n5T6tSjvIsjqbVqojaJdgDqq6jHwBVypoj6wq4Dzq+1N?=
 =?us-ascii?q?QYnH8HLE9KeR6elIjmJ03OIOjjAPehjFSjji1ry+rFPrL/GJXNKGbMkLP7cb?=
 =?us-ascii?q?Z68U5cx1l78dcK45NSF6FEO/nvQmfvu9HCSBw0KQq5x6DgEtou7I4GXXOzBf?=
 =?us-ascii?q?q9Oevqq16N5/4uPeDEMIscoCz8Lvk55uDngGQRi1gdeqyg3J9RZW3uTdp8JE?=
 =?us-ascii?q?DMRXOkus0AFGYWvxQ3BLj2lVmJUDJafF63VqM4oC02DI++BIyFXpz70+/J5z?=
 =?us-ascii?q?uyApADPjMOMVuLC3q9L4g=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EuEADyAANelyMYgtllgkSDFjcbIBK?=
 =?us-ascii?q?TQlQGdR2KEoUzg3wVhhoMgVsNAQEBAQE1AgEBhECCIiQ4EwIDDQEBBQEBAQE?=
 =?us-ascii?q?BBQQBAQIQAQEBAQEIFgaFc0IBDAGBayKEF4EDgSyDA4JTKa0iGgKFI4R0gTY?=
 =?us-ascii?q?BjBgaeYEHgUSCMoUCARIBbIUhBI1FIYhLYZd+gj4EljANgikBjDgDglSJEac?=
 =?us-ascii?q?igjdVgQuBCnFNOIFyGYEdTxgNjSyOLUCBFhACT4VAh1yCMgEB?=
X-IPAS-Result: =?us-ascii?q?A2EuEADyAANelyMYgtllgkSDFjcbIBKTQlQGdR2KEoUzg?=
 =?us-ascii?q?3wVhhoMgVsNAQEBAQE1AgEBhECCIiQ4EwIDDQEBBQEBAQEBBQQBAQIQAQEBA?=
 =?us-ascii?q?QEIFgaFc0IBDAGBayKEF4EDgSyDA4JTKa0iGgKFI4R0gTYBjBgaeYEHgUSCM?=
 =?us-ascii?q?oUCARIBbIUhBI1FIYhLYZd+gj4EljANgikBjDgDglSJEacigjdVgQuBCnFNO?=
 =?us-ascii?q?IFyGYEdTxgNjSyOLUCBFhACT4VAh1yCMgEB?=
X-IronPort-AV: E=Sophos;i="5.69,353,1571695200"; 
   d="scan'208";a="298525202"
Received: from mailrel04.vodafone.es ([217.130.24.35])
  by mail01.vodafone.es with ESMTP; 25 Dec 2019 07:28:04 +0100
Received: (qmail 32295 invoked from network); 25 Dec 2019 04:33:52 -0000
Received: from unknown (HELO 192.168.1.88) (seigo@[217.217.179.17])
          (envelope-sender <tulcidas@mail.telepac.pt>)
          by mailrel04.vodafone.es (qmail-ldap-1.03) with SMTP
          for <linux-sctp@vger.kernel.org>; 25 Dec 2019 04:33:52 -0000
Date:   Wed, 25 Dec 2019 05:33:43 +0100 (CET)
From:   La Primitiva <tulcidas@mail.telepac.pt>
Reply-To: La Primitiva <laprimitivaes@zohomail.eu>
To:     linux-sctp@vger.kernel.org
Message-ID: <29088017.259407.1577248423672.JavaMail.javamailuser@localhost>
Subject: Take home 750,000 Euros this end of year
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Attn: Email User,

You have won, you are to reply back with your name and phone number for
claim.

La Primitiva




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.

