Return-Path: <linux-sctp+bounces-670-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C3CC02C2A
	for <lists+linux-sctp@lfdr.de>; Thu, 23 Oct 2025 19:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9BE3B0D5F
	for <lists+linux-sctp@lfdr.de>; Thu, 23 Oct 2025 17:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E6734B422;
	Thu, 23 Oct 2025 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQvTCQ2p"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC13534B408
	for <linux-sctp@vger.kernel.org>; Thu, 23 Oct 2025 17:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761241094; cv=none; b=bn7yrMWGbj1JxEeSns8PHfqAgsK49O8OhrnTIrt8gl3iUzB/QMoC4ECW9OAADpoTfSmLBimwXn9K6bPB53t8p19fltGkA1nwUN3rHYf6ocEfsHBpt+J9kuVb6toZo64MwVKAF9eChvUwRYEulpxJ0jRzqSh4Uxml4BiX81IIlTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761241094; c=relaxed/simple;
	bh=ywuqBEwRpRScnW+bb5t/i7Wkw4UY4DDO5j+kmL9KXEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdusQRkgcKytzY6374jsM1U8ayQqgu4l3nsWW2WPuhokvi7PnyHjqBntPmZ3sfO+Hz5T3RFr38YNHm5WatQajhnFaKHrp/Hvq1TQdxJUg9KBpR9CfjvotD1LJLH9C2sTrNKCxB0Sq41vHHzO7ia8ZAKhi6J52Jxdw4ufVHhqtqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQvTCQ2p; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-290aaff26c1so2483025ad.3
        for <linux-sctp@vger.kernel.org>; Thu, 23 Oct 2025 10:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761241092; x=1761845892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywuqBEwRpRScnW+bb5t/i7Wkw4UY4DDO5j+kmL9KXEA=;
        b=WQvTCQ2poQ0X9GhbZuZkC9Z4n1R0iEJDBtYFiyVZ3meO8N9uKX1HVXbvcP+9/b0DxG
         6iVcPY/brnKMN2r+VNHegV0SY4w/c6ERr5yDJq5z+SqusZUrRo/tJHIIHDADWh31qVxv
         BaezDXoL7fp30b8l+GXtAzWTsh7vo1rzve9hxJlJX+75aCa3w+8N6aBdQMg11AzaNurQ
         Ouk8ClgLzowIVgGb0ENVkbExGBkmKndvmmOBVhb0W75Haavx/RGKlx3b1ZAB9jxlXMoE
         d/70SFMOrYugIjnaWAsHqMQO5hlAF+TWX4CkFofAPO6rujT3LcUFI2vwJmMSK3Q7xMwM
         lmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761241092; x=1761845892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywuqBEwRpRScnW+bb5t/i7Wkw4UY4DDO5j+kmL9KXEA=;
        b=Rx1NTCweOyRCdD99cMVY1xlJNU36zEgaP+7N+Ra7+3/pxsV7FEZ61Xm30iNFsompEa
         wtO+q4vcuxq5nZq8tnmo3Tvi3bQMUXV/2jucGWRUfL+BXlMACtDbz50uktjZEAfeFdje
         qmngRMCHxRDjYSnEKkZXYOL/VRVnb1+3YOZmP8SpxZ3idPzuN8UvJ20jbaLeG+BGOkoN
         OM4XpkGVwILSgfSh+qM0iK6tBbOKHesjAjJMLWoBF0gMFyAYJQZFOBMYPN1k78RtQsYx
         GQG8raw67xOizGyI8lFQBMivwMleoTcY/TGdZkuQwrTWLtWGz8NRLAqOGWjciXlG/4l3
         S2KA==
X-Forwarded-Encrypted: i=1; AJvYcCXo9kUkPO/Ldd53ruadPGLm6PFE+eLkSIuKx/iQcLvjfuYO6ig35SweyArsLfgAiIKbcjGx8LUiULwm@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvcw+wfx3E9UoQHHbUtgC8tCRjODzenGPXCd/OR9E/1C/To5hq
	Jn/4fDdEUWkVM0ohuiEbwL4OK2rwWBgL/5kN30vWsLFCzfSGFcpoWIEg
X-Gm-Gg: ASbGncui6apXwqWhD4aDB1hba93adCXKvM5VDpy+RK/OGOaRvbIVcEKH4N+REH/eyMz
	1Q5XGnm2AWGd2OTgRGuDDmhqWTo4fjmuum4mdXtDLY5n8Tl9WKg3A912ARKt2D3Li+4kLdzJNMi
	575BrhohYLZkEBgJF1aR3XvSxx4PK/fDTFpiOWcPviLt111K1vlIWNecpvyBlP91nDla6x6mdR1
	BBTzOTExWLw0TVz53+Qct1YGXJEa6m2gWgd+Ymtoy9w6b96ExvqQJBNtkhd4n/ZRa/H6lJWMDbk
	X4gSFQ7Inpp1NpdskQTN/uhWgZ/EXu6kFHFJKgPESF/Ou58zxxFX+mZlbGUFfIuC84ZwE2+i1U/
	L3kBlBIozBFiDlOl5NCrjfnCFthyCiTq0hj0nBpYlq+AsoLmJUY/PPVyNW+7S2mGI3uwjdgOigf
	rPeeSWAVIiLZnNS5vn7YXY4DgZsN2tYzUrDhi+I2CYD/swM3PhixP/wUcHmBJNPp4=
X-Google-Smtp-Source: AGHT+IHS0h+JRFSFpKN3ABn8gJENaNAJSEiO+0aN8t2XO48O5XiQnQC/G+gPhMwXVqJDR85nhMuBag==
X-Received: by 2002:a17:903:2a8d:b0:27e:eee6:6df2 with SMTP id d9443c01a7336-292d3fb7f47mr76907185ad.7.1761241091900;
        Thu, 23 Oct 2025 10:38:11 -0700 (PDT)
Received: from ranganath.. ([2401:4900:c919:de72:5515:28c0:ad28:8093])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946ddea29csm29417515ad.30.2025.10.23.10.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 10:38:11 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
To: lucien.xin@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	marcelo.leitner@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	vnranganath.20@gmail.com
Subject: Re: [PATCH] net: sctp: fix KMSAN uninit-value in sctp_inq_pop
Date: Thu, 23 Oct 2025 23:08:01 +0530
Message-ID: <20251023173801.11428-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CADvbK_c2zqQ76kzPmTovWqpRdN2ad7duHsCs9fW9oVNCLdd-Xw@mail.gmail.com>
References: <CADvbK_c2zqQ76kzPmTovWqpRdN2ad7duHsCs9fW9oVNCLdd-Xw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xin,

Thank you for the feedback and response to the patch.
I would like to know that above analysis is valid or not.
And do you want me to test this suggestion with the syzbot?

regards,
Ranganath

