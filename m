Return-Path: <linux-sctp+bounces-751-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E11D2C91EC6
	for <lists+linux-sctp@lfdr.de>; Fri, 28 Nov 2025 13:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A7A033437A0
	for <lists+linux-sctp@lfdr.de>; Fri, 28 Nov 2025 12:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70D030FC13;
	Fri, 28 Nov 2025 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZikKZe9W"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E4A315776
	for <linux-sctp@vger.kernel.org>; Fri, 28 Nov 2025 11:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764331171; cv=none; b=rQ2Q+1RqOBAPHgHPqUst7SuATU53/p/qBVKeStDqXqzXyYq5DHFDBL4MMtMaw4CQZRG0E9wU7H8bUUd34yk9sMYhmsIDzuwZi/ZROvpQKIcEqtLPK3wRfmnD/gy9ygdK1Bui/dewNI97eoQAdLV51vucEvwFG6vFPl4gAnWYnyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764331171; c=relaxed/simple;
	bh=p/LI/4DlurwdA59OHQ4OvooBx7BVUVV0rBYnsAZuVdE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cbtlhvPD/PmnRSoqy+/ApHNVULDz5f0qshB2uYs11mjcPFGvUx2S1Rz6McfPFaAQAJSu2cqIFkpIqsAcTLXYbBN/HY62XRWwSLm0fJl8jiAlDtwoRo4zF3b8oDZ0QQcPzDAK6xQrQtZcdu1IwvUVvszPssHd26R8eg82gBnnk7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZikKZe9W; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47795f6f5c0so9487665e9.1
        for <linux-sctp@vger.kernel.org>; Fri, 28 Nov 2025 03:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764331168; x=1764935968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7xZKxP4FWw1ZBylIQ8YoBNDN7l4i8QKo3cyzTdeQdQ=;
        b=ZikKZe9W8svLwX5wR/T4r4IFjiwcNqlGHJvnOgvqRd5t0fHjZIgXH3Z/hz4evc1hra
         vRg+SupQZ5u84MdCErqHpWDqIFX4RzGir4VEV2nRHcWPB+FyRSNDVdvtxIPEtMYDVHwt
         x4+KUWHHjjZZC8R1Q9oFw2D9OyY/w9aZOto9RsSiW2vMJcRIWYFebsyIGCrEZxtLgjsj
         4yvOYCNr+eK7tcgqdDqbBl5xrcOOCwLddjLDyqm/PtSaEpl94P+Jhag4oAhqBAKwVQI1
         QdqNUpQwC0w9gekSGjGCS4DByjkmUD2zTQRmGlefFcBdAw65w25ZSJBeM/vZrfI/WKBP
         fDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764331168; x=1764935968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y7xZKxP4FWw1ZBylIQ8YoBNDN7l4i8QKo3cyzTdeQdQ=;
        b=jYigHEqE912DAVF8j+TaWXpqNpdrhuodQxrl/akjWXFdzEqxXyqiJT36evkvbKptM+
         5ZY6hJrcVBba6I/EuD2dvgAnF1h05Aj32xqIOCEt7PfOOcNdHkHUGqpzc0/Q8e2eJE8K
         lpYQMweeAkQrx0kjb8l8QY0zjLxZl5u9VsrNB9YBKl1aaeySJWwy1R6p5GPHji3yjF28
         mmpwj5A8tulqyaan7rj5DCQ6NxJNj55XTq+Ix44kyLB+pvF4wU0YIkTFPgVM6E/6bgbj
         4c+VLS6nh3LJw9Z+zrGY/V+UA+wE6ezpYE8n1uMZhLLLd24SgjVAoKW2dP7hGZzk7s4S
         Y2Tw==
X-Gm-Message-State: AOJu0YxZnPTy3ikd/mi6nsIOdlwvG5SuIXJO+INLr5p5Xwa83MrfDmzj
	H6yFkkg10dhVOpFpdo9xu1PdD/SGo9RPkAneXqtpdoa/Xh/AmzuyCVxrJ9MVsg==
X-Gm-Gg: ASbGnct6nkifHT9HERmThAMdYf4d3kEOfrgeTYliGL+yp3SKk3VA3ASv8+5LcFWHq6n
	/3Kq3eOLFGsXi6yBxRRHpSQlLO2J+XCyAIz3XF0FlSGKuvDWNrLNiwPtLGYjRg273lze0MWC2S4
	WQKS8Ze41X8Nsa3kkG6P3pLMuTT3c9NB/Ncz/w070GRKYP2s/jkqz/RIJxE69S53oJPaoxhqWMG
	b/mwvMxTxakzqS+QqTuWK4oZoRK9hYb4xHspuES3mZLhITZp9iCpt5HDxZdgYvA4AvIT/cLaYYw
	j2b8esude+sd1XMc1gY2vQk+A9N4tG05A6yoCNjSnGZhvwvm6CzimITLaMTvvd/khEdtAfzWVTG
	rJ/oZRPK/ezyc1Qgra1xprkJpkoEkhalzreDy/US1szRoik0NAt6lxIX8zatsJbdW5P2LDo7mwO
	gTAXlpESxTZqcb6votY7ICZabp4joX7h+yaj6DeEx7XT+FpNrm+ukM
X-Google-Smtp-Source: AGHT+IFvxvASfs10rPYsnSWNA16Ef5sn60Sqk9/feh29Wxgxib0MehM+Gwhehpl3sKDC7l+khNwaPA==
X-Received: by 2002:a05:600c:4746:b0:477:1bb6:17de with SMTP id 5b1f17b1804b1-477c01e2521mr290325095e9.30.1764331168061;
        Fri, 28 Nov 2025 03:59:28 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47905303963sm89769185e9.7.2025.11.28.03.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 03:59:27 -0800 (PST)
Date: Fri, 28 Nov 2025 11:59:26 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: linux-sctp@vger.kernel.org
Subject: Re: sctp on RHEL9
Message-ID: <20251128115926.77d8b5a5@pumpkin>
In-Reply-To: <pzrmyhcns6wwyiouqashxwryeakcajvxaqwyr7vl2vxvcwkzi4@eltvekq6ok6n>
References: <20251118230743.5a862e9a@pumpkin>
	<pzrmyhcns6wwyiouqashxwryeakcajvxaqwyr7vl2vxvcwkzi4@eltvekq6ok6n>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Nov 2025 08:45:52 -0300
Marcelo Ricardo Leitner <marcelo.leitner@gmail.com> wrote:

> On Tue, Nov 18, 2025 at 11:07:43PM +0000, David Laight wrote:
> > A bit of a gamble...
> > 
> > Anyone any idea why RHEL9 should reject sctp setsockopt() calls like SCTP_INITMSG?  
> 
> More likely an invalid buffer as argument. It has to have the exact
> size of struct sctp_initmsg, and not more than that.

It was resolved.
Basically the code is an out of tree driver and they were using an old version
that calls kernel_setsockopt().
That was removed from the kernel well before the one RHEL9 is based on, so we'd
expected they get a build error (the driver usually runs if it builds).
But it seems RHEL9 has a wrapper for kernel_setsockopt() that doesn't actually work.
The later driver has its own correct wrapper and worked fine.

	David


