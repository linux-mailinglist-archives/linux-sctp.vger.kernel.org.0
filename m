Return-Path: <linux-sctp+bounces-625-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A3DB97EEB
	for <lists+linux-sctp@lfdr.de>; Wed, 24 Sep 2025 02:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D76337A8C18
	for <lists+linux-sctp@lfdr.de>; Wed, 24 Sep 2025 00:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3888B1D63DF;
	Wed, 24 Sep 2025 00:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b="ZiLM3Bz/"
X-Original-To: linux-sctp@vger.kernel.org
Received: from sender4-g3-154.zohomail360.com (sender4-g3-154.zohomail360.com [136.143.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2C31A23AF
	for <linux-sctp@vger.kernel.org>; Wed, 24 Sep 2025 00:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674646; cv=pass; b=J4ewVabfzsO/+2s7k/fwGiB3XM8/bJueVQfE4u6RBAdzE1FzUijopDkDrgE1bESQOqCAjBINrXoEQjPU0q5cO2aKpaYNUGK0Nsxg9Uhdp9fzCEe/nrEk4oCvwOcXnK5BLzV8iP3ers5sMowXgvqV+z/9wbYdHxY279BFwnz3axg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674646; c=relaxed/simple;
	bh=1U6Xrk0iQho0qKEu+JSGj9wlFlOuA4kdIlXAorX4BUg=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=BhqnByQCrAEQCCAuy0tMBWv2InMV+FfO9r7SI2VKbLtMQk0qwY8M36+9pqAhH75znl5VGqMHEXt4x+ko1J5gCtywnJt9rTbg0l1mLz49DrqP6FdJFtJ07Fi4NmitUH75EfEES1goF+RMsvBt+DhfTtjxQjqHwS+ClIjcNtRG88E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx; dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b=ZiLM3Bz/; arc=pass smtp.client-ip=136.143.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx
ARC-Seal: i=1; a=rsa-sha256; t=1758674643; cv=none; 
	d=us.zohomail360.com; s=zohoarc; 
	b=VSMm6F7upaXi8c3I+9fbWuDR7koaQr1idCEf3YzOYAaDiJq//DWvErs8mCJ0eIU4jZCLC63L9w8Swu4gBKoX+bRzCI+bdKPgBf+TGY4fSeVV8WbmCoG7y6FVujgeQ0NQ3MnBK2PCITrvSa/Ljp7tFWK8fkn7XQjRpiyL8sdp9XY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=us.zohomail360.com; s=zohoarc; 
	t=1758674643; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id:Cc; 
	bh=1U6Xrk0iQho0qKEu+JSGj9wlFlOuA4kdIlXAorX4BUg=; 
	b=kUtAv6rA/VkrlyK3jCGSIzgxu3sqlz2TlNGUXjdxIFNfDg29X4GngIrsSPd1vWjeLRE5dKTGvJImeE97GbGP85Nat+Br339cPcYnE+/8Qm1OQxH2/Wr9EFT5cjD0GxxxzTAw9uXtnXnfEEuJRm1IpY6LEtCSjc2T52iOx/+6eDw=
ARC-Authentication-Results: i=1; mx.us.zohomail360.com;
	dkim=pass  header.i=maguitec.com.mx;
	spf=pass  smtp.mailfrom=investorrelations+9ab55ba1-98d8-11f0-ace3-525400721611_vt1@bounce-zem.maguitec.com.mx;
	dmarc=pass header.from=<investorrelations@maguitec.com.mx>
Received: by mx.zohomail.com with SMTPS id 1758671653530431.29390503715615;
	Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=ZiLM3Bz/19xXfGeo9qYTk2eqjJ25ADQZeEuzO5ThaJF83ynEGQ/pF8w4gmJYjqK+GNLORz8AQHBu76ke0nrgDMR25FNphcqfqioK/mot4X62gwyyiSlbZ/1KxWl0FZXPylEaeLl9mJphD05BECQXGLW6vJhAYEQcNHS4yQb/fto=; c=relaxed/relaxed; s=15205840; d=maguitec.com.mx; v=1; bh=1U6Xrk0iQho0qKEu+JSGj9wlFlOuA4kdIlXAorX4BUg=; h=date:from:reply-to:to:message-id:subject:mime-version:content-type:content-transfer-encoding:date:from:reply-to:to:message-id:subject;
Date: Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
From: Al Sayyid Sultan <investorrelations@maguitec.com.mx>
Reply-To: investorrelations@alhaitham-investment.ae
To: linux-sctp@vger.kernel.org
Message-ID: <2d6f.1aedd99b146bc1ac.m1.9ab55ba1-98d8-11f0-ace3-525400721611.19978ffc65a@bounce-zem.maguitec.com.mx>
Subject: Thematic Funds Letter Of Intent
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
content-transfer-encoding-Orig: quoted-printable
content-type-Orig: text/plain;\r\n\tcharset="utf-8"
Original-Envelope-Id: 2d6f.1aedd99b146bc1ac.m1.9ab55ba1-98d8-11f0-ace3-525400721611.19978ffc65a
X-JID: 2d6f.1aedd99b146bc1ac.s1.9ab55ba1-98d8-11f0-ace3-525400721611.19978ffc65a
TM-MAIL-JID: 2d6f.1aedd99b146bc1ac.m1.9ab55ba1-98d8-11f0-ace3-525400721611.19978ffc65a
X-App-Message-ID: 2d6f.1aedd99b146bc1ac.m1.9ab55ba1-98d8-11f0-ace3-525400721611.19978ffc65a
X-Report-Abuse: <abuse+2d6f.1aedd99b146bc1ac.m1.9ab55ba1-98d8-11f0-ace3-525400721611.19978ffc65a@zeptomail.com>
X-ZohoMailClient: External

To: linux-sctp@vger.kernel.org
Date: 24-09-2025
Thematic Funds Letter Of Intent

It's a pleasure to connect with you

Having been referred to your investment by my team, we would be=20
honored to review your available investment projects for onward=20
referral to my principal investors who can allocate capital for=20
the financing of it.

kindly advise at your convenience

Best Regards,

Respectfully,
Al Sayyid Sultan Yarub Al Busaidi
Director

